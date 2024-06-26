```

    _  _   _            _           _           
  _| || |_(_)          | |         | |          
 |_  __  _|_ _ __   ___| |_   _  __| | ___  ___ 
  _| || |_| | '_ \ / __| | | | |/ _` |/ _ \/ __|
 |_  __  _| | | | | (__| | |_| | (_| |  __/\__ \
   |_||_| |_|_| |_|\___|_|\__,_|\__,_|\___||___/
                                                
                                                

```

| Include            | Descrição                                                                                                                                                                                   |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Ap5Mail.ch**      | Include utilizada antigamente para disparo de e-Mail, não sendo mais necessária no dias de hoje, bastando utilizar a Include TOTVS.ch e a classe TMailMessage()                             |
| **ApWebSrv.ch**     | Include utilizada para a chamada de WebServices                                                                                                                                             |
| **ApWizard.ch**     | Include utilizada na criação de telas no formato Wizard, não sendo mais necessário o uso, se utilizado a Include TOTVS.ch e a classe FWWizardControl()                                      |
| **Colors.ch**       | Esta Include possui cores pré-definidas em constantes (como **CLR_HRED**, **CLR_HBLUE**, etc.), porém acredito ser mais fácil o uso da função **RGB()**.                                    |
| **FWMVCDef.ch**     | Include repleta de recursos e constantes para criação de fontes em **MVC                                                                                                                    |
| **FWPrintSetup.ch** | Include prove recursos e constantes para criação de relatórios gráficos, utilizando a classe **FWMSPrinter()**                                                                              |
| **FileIO.ch**       | Include utilizada para controlar input e output de arquivos, atualmente não sendo necessário o uso, se utilizar a Include **TOTVS.ch** e as classes **FWFileWriter()** e **FWFileReader()** |
| **Font.ch**         | Include de fontes, mas se fizer uso na Include TOTVS.ch e a classe TFont(), terá um resultado muito melhor.                                                                                 |
| **ParmType.ch**     | Include utilizada para tipagem de parâmetros vindo em funções, que atualmente pode ser substituído pelo uso da Include TOTVS.ch juntamente com prefixo Default ao se receber um parâmetro   |
| **PonCalen.ch**     | Include relacionada ao Ponto Eletrônico                                                                                                                                                     |
| **Protheus.ch**     | Include padrão do Protheus, devendo se utilizar como padrão a TOTVS.ch [¹][1]                                                                           |
| **RPTDef.ch**       | Include disponibiliza alguns recursos para relatórios do Protheus                                                                                                                           |
| **RWMake.ch**       | Include possui recursos para montagens da tela, a mesma antecede a Protheus.ch, mas atualmente deve-se utilizar a TOTVS.ch[¹][1]                                                                   |
| **TOTVS.ch**        | Include padrão para as customizações[¹][1]                                                                                                                                                         |
| **TbiCode.ch**      | Include comumente usada para fazer integrações entre sistemas, juntamente com TbiConn.ch                                                                                                    |
| **TbiConn.ch**      | Include comumente usada para fazer integrações entre sistemas, juntamente com TbiCode.ch                                                                                                    |
| **TopConn.ch**      | Include mantem recursos e funções para uso de conexões via Top Connect (como a tão utilizada TCQuery())                                                                                     |
| **XMLxFun.ch**      | Include com recursos para integração com arquivos XML, exemplo a função XMLDelNode()                                                                                                        |

[1]: https://tdn.totvs.com/display/public/PROT/ADV0100_CH_TOTVS_RDMAKE_PROTHEUS "Devo utilizar o include RWMake, Protheus ou Totvs.ch?"