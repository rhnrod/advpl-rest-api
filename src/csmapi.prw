// +====================================================================+
// |     _     ____ __     __ ____   _       ____   _____  ____  _____  |
// |    / \   |  _ \\ \   / /|  _ \ | |     |  _ \ | ____|/ ___||_   _| |
// |   / _ \  | | | |\ \ / / | |_) || |     | |_) ||  _|  \___ \  | |   |
// |  / ___ \ | |_| | \ V /  |  __/ | |___  |  _ < | |___  ___) | | |   |
// | /_/   \_\|____/   \_/   |_|    |_____| |_| \_\|_____||____/  |_|   |
// |                                                                    |
// +====================================================================+

#include 'totvs.ch'
#include 'restful.ch'

WsRestful clientes Description 'API para consultar clientes na tabela SA1' FORMAT APPLICATION_JSON

	WsData Pag AS Integer
	WsData Qtd AS Integer

	WsMethod GET  TODOS 										 												;
		Description 'Retorna todos os clientes da tabela SA1' WSSyntax '/' Path '/'
	WsMethod GET  UNIQUE 										 												;
		Description 'Retorna um cliente específico da tabela SA1' WSSyntax '/{id}/{loja}' Path '/{id}/{loja}'
	WsMethod POST NOVO_CLIENTE 																					;
		Description 'Inclui um novo cliente na tabela SA1' WSSyntax '/'	Path '/'								;
		PRODUCES APPLICATION_JSON
	WsMethod PUT ATUALIZAR																						;
		Description 'Atualizar dados de um cliente na tabela SA1' WSSyntax '/{id}/{loja}' Path '/{id}/{loja}'	;
		PRODUCES APPLICATION_JSON
	WsMethod DELETE DELETAR																						;
		Description 'Apaga o registro de um cliente na tabela SA1' WSSyntax '/{id}/{loja}' Path '/{id}/{loja}'	;
		PRODUCES APPLICATION_JSON

END WsRestful


// INFO :: Método GET 
WsMethod GET TODOS WsService clientes
	
	Local lRet  := .T.
	Local oJson	:= JsonObject():New()
	Local nPag       := 0
	Local nQtd       := 0

	Self:SetContentType('application/json')

	Default self:Pag := 1
	Default self:Qtd := 5

	nPag    := self:Pag
	nQtd    := self:Qtd

	oJson := u_getCli(nPag,nQtd)

	::SetResponse(oJson:toJson())

Return lRet

// INFO :: Método GET por id (A1_COD)
WsMethod GET UNIQUE WsService clientes

	Local lRet       := .T.
	Local oJson	:= JsonObject():New()
	Local cCod		 := ''
	Local cLoja		 := ''

	::SetContentType('application/json')

	IF len(::aUrlParms) == 0
		SetRestFault(400, "Um parâmetro era esperado, mas não foi informado!")
		Return .F.
	EndIF

	If len(::aUrlParms) < 2
		SetRestFault(400, "Um parâmetro loja era esperado, mas não foi informado!")
		Return .F.
	EndIF

	cCod  := ::aUrlParms[1]
	cLoja := ::aUrlParms[2]

	oJson := u_getClId(cCod, cLoja)

	::SetResponse(oJson:toJson())

Return lRet


// INFO :: Método POST
WsMethod POST NOVO_CLIENTE WsService clientes

	Local lRet	:= .T.
	Local cJson	:= ''
	Local oJson

	cJson := ::GetContent()

	IF Empty(cJson)
		SetRestFault(400, ENCODEUTF8('Aparentemente há um erro no corpo da requisição.'))
		Return .F.
	EndIF

	::SetContentType('application/json')

	oJson := u_postCl(cJson)

	IF oJson:HasProperty('status')
		If oJson['status'] <> 201
			::SetStatus(oJson['status'])

			lRet := .F.
		EndIF
	EndIF

	
	::SetResponse(oJson:toJson())

Return lRet

// INFO :: MÉTODO PUT
WsMethod PUT ATUALIZAR WsService clientes
	Local lRet 		:= .F.
	Local cBody 	:= ''
	Local cCod		:= ""
	Local cLoja		:= ""
	Local oJson

	::SetContentType('application/json')

	cBody := ::GetContent()
	
	IF Empty(cBody)
		SetRestFault(400, ENCODEUTF8('Aparentemente há um erro no corpo da requisição.'))
		Return .F.
	EndIF

	IF len(::aUrlParms) == 0
		SetRestFault(400, "Um parâmetro era esperado, mas não foi informado!")
		Return .F.
	EndIF

	If len(::aUrlParms) < 2
		SetRestFault(400, "Um parâmetro loja era esperado, mas não foi informado!")
		Return .F.
	EndIF

	cCod  := ::aUrlParms[1]
	cLoja := ::aUrlParms[2]

	oJson := u_putCli(cBody,cCod,cLoja)

	IF oJson:HasProperty('status')
		If oJson['status'] <> 201
			::SetStatus(oJson['status'])

			lRet := .F.
		EndIF
	EndIF

	
	::SetResponse(oJson:toJson())

Return lRet


// MÉTODO DELETE
WsMethod DELETE DELETAR WsService clientes
	
	Local lRet 		:= .F.

	::SetContentType('application/json')

	IF len(::aUrlParms) == 0
		SetRestFault(400, "Parâmetros eram esperados, mas não foram informado!")
		Return .F.
	EndIF

	If len(::aUrlParms) < 2
		SetRestFault(400, "Um parâmetro loja era esperado, mas não foi informado!")
		Return .F.
	EndIF

	cCod	:= ::aUrlParms[1]
	cLoja	:= ::aUrlParms[2]

	oJson := u_delCli(cCod,cLoja)

	IF oJson:HasProperty('status')
		If oJson['status'] <> 201
			::SetStatus(oJson['status'])

			lRet := .F.
		EndIF
	EndIF

	::SetResponse(oJson:toJson())

Return lRet

// ============================ FUNÇÕES ============================
//
// u_getCli		=> Método GET
// u_getClId	=> Método GET por id (A1_COD, A1_LOJA)
// u_postCl		=> Método POST																	 
// u_putCli		=> Método PUT 															 
// u_delCli		=> Método DELETE		
//												 
// =================================================================

/*/{Protheus.doc} Function u_getCli
	Função que retorna os clientes cadastrados na tabela SA1.
	@type  Function
	@author Rhuan Emanuel
	@since 23/05/2024
	@version 0.5
	@params pags, integer, define qual página para paginação
	@params qtds, integer, define o limite de retornos por página para paginação
	@return oJsonRet, object, retorna um Json contendo o total de registros da tabela e os clientes por página 
	/*/
function u_getCli(pags,qtds)
    Local oJson      := JsonObject():new()
	Local oJsonRet   := JsonObject():new()
	Local aClientes  := {}
	Local cAlias     := GetNextAlias()
	Local nTotal	 := 0

	Local nPags := pags
	Local nQtds := qtds

	// Paginação
	BeginSQL Alias cAlias

		SELECT A1_FILIAL,
			A1_COD,
			A1_NOME,
			A1_CGC,
			A1_TIPO
		FROM %Table:SA1% SA1
		WHERE SA1.%notdel%
		ORDER BY A1_FILIAL,A1_COD,A1_NOME,A1_CGC,A1_TIPO
		LIMIT %exp:nQtds%
		OFFSET (%exp:nPags% - 1) * %exp:nQtds%

	EndSQL

	(cAlias)->(dbGoTop())

	// Varre todos os clientes
	While (cAlias)->(!eof())

		oJson                  := JsonObject():new()
		oJson['filial']        := (cAlias)->A1_FILIAL
		oJson['codigo']        := (cAlias)->A1_COD
		oJson['nome']          := (cAlias)->A1_NOME
		oJson['cgc']           := (cAlias)->A1_CGC
		oJson['tipoPessoa']    := (cAlias)->A1_TIPO

		aadd(aClientes,oJson)

		(cAlias)->(dbSkip())

	Enddo

	(cAlias)->(dbCloseArea())

	BeginSQL Alias cAlias

		SELECT A1_FILIAL,
			A1_COD,
			A1_NOME,
			A1_CGC,
			A1_TIPO
		FROM %Table:SA1% SA1
		WHERE SA1.%notdel%

	EndSQL

	Count to nTotal

	(cAlias)->(dbGoTop())
	(cAlias)->(dbCloseArea())


	oJsonRet['count']    := nTotal
	oJsonRet['rows']     := aClientes

	oJsonRet:ToJson()

Return oJsonRet


/*/{Protheus.doc} Function u_getClId
	Função que retorna um cliente específico cadastrados na tabela SA1.
	@type  Function
	@author Rhuan Emanuel
	@since 23/05/2024
	@version 0.5
	@params cliCod, integer, define qual o código (A1_COD) do cliente deve retornar
	@params cliLoja, integer, define qual a loja (A1_LOJA) do cliente deve retornar
	@return oJsonRet, object, retorna um Json contendo o total de registros da tabela e os clientes por página 
	/*/
Function u_getClId(cliCod, cliLoja)
	Local cAlias     := GetNextAlias()


	BeginSQL Alias cAlias
            SELECT A1_FILIAL,
                A1_COD,
                A1_LOJA,
                A1_NOME,
                A1_CGC,
                A1_TIPO
            FROM %Table:SA1% SA1
            WHERE SA1.A1_FILIAL = %xFilial:SA1%
				AND SA1.A1_COD 	= %exp:cliCod%
				AND SA1.A1_LOJA = %exp:cliLoja%
				AND SA1.%notdel%
            ORDER BY A1_FILIAL,A1_COD,A1_LOJA,A1_NOME,A1_CGC,A1_TIPO
	EndSQL

	IF (cAlias)->(eof())
		SetRestFault(404, ENCODEUTF8( "Usuário não encontrado."))
		Return
	Else
		oJsonRet                  := JsonObject():new()
		oJsonRet['filial']        := (cAlias)->A1_FILIAL
		oJsonRet['codigo']        := (cAlias)->A1_COD
		oJsonRet['loja']          := (cAlias)->A1_LOJA
		oJsonRet['nome']          := (cAlias)->A1_NOME
		oJsonRet['cgc']           := (cAlias)->A1_CGC
		oJsonRet['tipoPessoa']    := (cAlias)->A1_TIPO
	EndIF

	(cAlias)->(dbCloseArea())

Return oJsonRet


/*/{Protheus.doc} Function u_postCl
	Função que retorna um cliente específico cadastrado na tabela SA1.
	@type  Function
	@author Rhuan Emanuel
	@since 23/05/2024
	@version 0.5
	@params cliCod, integer, define qual o código (A1_COD) do cliente deve retornar
	@params cliLoja, integer, define qual a loja (A1_LOJA) do cliente deve retornar
	@return oJsonRet, object, retorna um Json contendo o total de registros da tabela e os clientes por página 
	/*/
Function u_postCl(json)
	
	Local cJson 	:= json
	Local oJson 	:= JsonObject():New()


	Private lMsErroAuto		:= .F.
	Private lMsHelpAuto		:= .T.
	Private lAutoErrNoFile 	:= .T.

	oJson:FromJson(cJson)

	IF Empty(cJson)
		SetRestFault(500, ENCODEUTF8('Aparentemente há um erro no corpo da requisição.'))
		Return
	EndIF

	lDeuCerto := .F.

	//Pegando o modelo de dados, setando a operação de inclusão
	oModel := FWLoadModel("CRMA980") //"MATA030" na antiga MATA030
	oModel:SetOperation(3)
	oModel:Activate()

	//Pegando o model dos campos da SA1
	oSA1Mod:= oModel:getModel("SA1MASTER") 								//"MATA030_SA1" na antiga MATA030
	oSA1Mod:setValue("A1_COD",       GetSXENum('SA1','A1_COD')        ) // Codigo
	oSA1Mod:setValue("A1_LOJA",      oJson['cliLoja']     			  ) // Loja
	oSA1Mod:setValue("A1_NOME",      oJson['cliNome']				  ) // Nome
	oSA1Mod:setValue("A1_NREDUZ",    oJson['cliNomeReduz']			  ) // Nome reduz.
	oSA1Mod:setValue("A1_END",       oJson['cliEndereco']			  ) // Endereco
	oSA1Mod:setValue("A1_BAIRRO",    oJson['cliBairro']				  ) // Bairro
	oSA1Mod:setValue("A1_TIPO",      oJson['cliTipo']				  ) // Tipo
	oSA1Mod:setValue("A1_EST",       oJson['cliEstado']				  ) // Estado
	oSA1Mod:setValue("A1_COD_MUN",   oJson['cliCodMun']				  ) // Codigo Municipio
	oSA1Mod:setValue("A1_MUN",       oJson['cliMunicipio']			  ) // Municipio
	oSA1Mod:setValue("A1_CEP",       oJson['cliCEP']				  ) // CEP
	oSA1Mod:setValue("A1_INSCR",     oJson['cliInscEst']			  ) // Inscricao Estadual
	oSA1Mod:setValue("A1_CGC",       oJson['cliCGC']				  ) // CNPJ/CPF
	oSA1Mod:setValue("A1_PAIS",      oJson['cliPais']				  ) // Pais
	oSA1Mod:setValue("A1_EMAIL",     oJson['cliEmail']				  ) // E-Mail
	oSA1Mod:setValue("A1_DDD",       oJson['cliDDD']				  ) // DDD
	oSA1Mod:setValue("A1_TEL",       oJson['cliTelefone']			  ) // Fone
	oSA1Mod:setValue("A1_PESSOA",    oJson['cliTipoPessoa']			  ) // Tipo Pessoa

	aErro := oModel:GetErrorMessage()
	cErroMsg := aErro[05] + ": " + aErro[06]

	//Se conseguir validar as informações
	If oModel:VldData()

		//Tenta realizar o Commit
		If oModel:CommitData()
			lDeuCerto := .T.
		EndIF
	EndIf

	//Se não deu certo a inclusão, mostra a mensagem de erro
	If ! lDeuCerto

		oJsonResp := JsonObject():New()

		oJsonResp['status'] 	:= 400
		oJsonResp['message']   	:= EncodeUTF8(cErroMsg)

		//Mostra a mensagem de Erro
		CONOUT("================================================================")
		CONOUT(aErro[06])
		CONOUT(aErro[07])
		CONOUT("================================================================")

		Return oJsonResp

	EndIf

	//Desativa o modelo de dados
	oModel:DeActivate()

Return oJson


/*/{Protheus.doc} Function u_putCli
	Função que atualiza um cliente específico cadastrado na tabela SA1.
	@type  Function
	@author Rhuan Emanuel
	@since 23/05/2024
	@version 0.5
	@params body, json, passa os dados enviados no corpo da requisição
	@params cod, integer, define qual o código (A1_COD) do cliente que deve ser atualizado
	@params loja, integer, define qual a loja (A1_LOJA) do cliente que deve ser atualizado
	@return oJsonRet, object, retorna um Json contendo o total de registros da tabela e os clientes por página 
/*/
Function u_putCli(body,cod,loja)
	
	Local cAlias	:= GetNextAlias()
	Local oJson 	:= JsonObject():New()

	Private lMsErroAuto		:= .F.
	Private lMsHelpAuto		:= .T.
	Private lAutoErrNoFile 	:= .T.

	lDeuCerto := .F.

	oJson:FromJson(body)


	SA1->(dbSetOrder(1))
	IF SA1->(dbSeek(xFilial('SA1')+alltrim(cod)+alltrim(loja)))

		oModel := FWLoadModel("CRMA980") //"MATA030" na antiga MATA030
		oModel:SetOperation(4) // Alteração
		oModel:Activate()

		// oJson:HasProperty(dado) verifica se um JsonObject possui um determinada chave

		//Pegando o model dos campos da SA1
		oSA1Mod:= oModel:getModel("SA1MASTER") 									//"MATA030_SA1" na antiga MATA030

		IF oJson:HasProperty("cliNome")
			oSA1Mod:setValue("A1_NOME",      oJson['cliNome']				  ) // Nome
		EndIF

		IF oJson:HasProperty("cliNomeReduz")
			oSA1Mod:setValue("A1_NREDUZ",    oJson['cliNomeReduz']			  ) // Nome reduz.
		EndIF

		IF oJson:HasProperty("cliEndereco")
			oSA1Mod:setValue("A1_END",       oJson['cliEndereco']			  ) // Endereco
		EndIF


		IF oJson:HasProperty("cliBairro")
			oSA1Mod:setValue("A1_BAIRRO",    oJson['cliBairro']				  ) // Bairro
		EndIF

		IF oJson:HasProperty("cliTipo")
			oSA1Mod:setValue("A1_TIPO",      oJson['cliTipo']				  ) // Tipo
		EndIF

		IF oJson:HasProperty("cliEstado")
			oSA1Mod:setValue("A1_EST",       oJson['cliEstado']				  ) // Estado
		EndIF

		IF oJson:HasProperty("cliCodMun")
			oSA1Mod:setValue("A1_COD_MUN",   oJson['cliCodMun']				  ) // Codigo Municipio
		EndIF

		IF oJson:HasProperty("cliMunicipio")
			oSA1Mod:setValue("A1_MUN",       oJson['cliMunicipio']			  ) // Municipio
		EndIF

		IF oJson:HasProperty("cliCEP")
			oSA1Mod:setValue("A1_CEP",       oJson['cliCEP']				  ) // CEP
		EndIF

		IF oJson:HasProperty("cliInscEst")
			oSA1Mod:setValue("A1_INSCR",     oJson['cliInscEst']			  ) // Inscricao Estadual
		EndIF

		IF oJson:HasProperty("cliCGC")
			oSA1Mod:setValue("A1_CGC",       oJson['cliCGC']				  ) // CNPJ/CPF
		EndIF

		IF oJson:HasProperty("cliPais")
			oSA1Mod:setValue("A1_PAIS",      oJson['cliPais']				  ) // Pais
		EndIF

		IF oJson:HasProperty("cliEmail")
			oSA1Mod:setValue("A1_EMAIL",     oJson['cliEmail']				  ) // E-Mail
		EndIF

		IF oJson:HasProperty("cliDDD")
			oSA1Mod:setValue("A1_DDD",       oJson['cliDDD']				  ) // DDD
		EndIF

		IF oJson:HasProperty("cliTelefone")
			oSA1Mod:setValue("A1_TEL",       oJson['cliTelefone']			  ) // Fone
		EndIF

		IF oJson:HasProperty("cliTipoPessoa")
			oSA1Mod:setValue("A1_PESSOA",    oJson['cliTipoPessoa']			  ) // Tipo Pessoa
		EndIF


		If oModel:VldData()

			//Tenta realizar o Commit
			If oModel:CommitData()

				oJsonResp := JsonObject():New()

				oJsonResp['message'] := EncodeUTF8('Registro alterado com sucesso.')

				Return oJsonResp
			EndIF
		EndIf

		//Se não deu certo, mostra a mensagem de erro
		If ! lDeuCerto

			aErro := oModel:GetErrorMessage()
			cErroMsg := aErro[05] + aErro[06]

			oJsonResp := JsonObject():New()

			oJsonResp['status'] 	:= 400
			oJsonResp['message'] 	:= EncodeUTF8(cErroMsg)


			//Mostra a mensagem de Erro
			CONOUT("================================================================")
			CONOUT(aErro[06])
			CONOUT(aErro[07])
			CONOUT("================================================================")

			Return oJsonResp

		EndIf

		//Desativa o modelo de dados
		oModel:DeActivate()
		(cAlias)->(dbCloseArea())

	Else

		SetRestFault(404, EncodeUTF8("Cliente não encontrado!"))
		Return .F.

	EndIF


Return oJson


/*/{Protheus.doc} Function u_delCli
	Função que atualiza um cliente específico cadastrado na tabela SA1.
	@type  Function
	@author Rhuan Emanuel
	@since 23/05/2024
	@version 0.5
	@params cliCod, integer, define qual o código (A1_COD) do cliente deve retornar
	@params cliLoja, integer, define qual a loja (A1_LOJA) do cliente deve retornar
	@return oJsonRet, object, retorna um Json contendo o total de registros da tabela e os clientes por página 
	/*/
Function u_delCli(cod,loja)
	
	Local cAlias	:= GetNextAlias()
	Local cCod		:= ""
	Local cLoja		:= ""

	Private lMsErroAuto		:= .F.
	Private lMsHelpAuto		:= .T.
	Private lAutoErrNoFile 	:= .T.


	lDeuCerto := .F.

	SA1->(dbSetOrder(1))
	IF SA1->(dbSeek(xFilial('SA1')+alltrim(cCod)+alltrim(cLoja)))

		oModel := FWLoadModel("CRMA980") //"MATA030" na antiga MATA030
		oModel:SetOperation(5) 			 // Exclusão
		oModel:Activate()

		If oModel:VldData()
			//Tenta realizar o Commit
			If oModel:CommitData()

				
				oJsonResp := JsonObject():New()
				oJsonResp['message'] := EncodeUTF8('Registro excluído com sucesso.')
				
				Return oJsonResp
			EndIF
		EndIf

		(cAlias)->(dbCloseArea())

	Else
		oJsonResp := JsonObject():New()
		oJsonResp['status'] := 404
		oJsonResp['message'] := EncodeUTF8('Cliente não encontrado!')

		Return oJsonResp

	EndIF

Return
