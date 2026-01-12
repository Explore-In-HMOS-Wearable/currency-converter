import { CurrencyData } from '../viewmodel/CurrencyData';
import { CurrencyViewModel } from '../viewmodel/CurrencyViewModel';
import { ExchangePage } from './ExchangePage';
import { SelectCurrencyPage } from './SelectCurrencyPage';
import { SplashPage } from './SplashPage';

@Entry
@Component
struct NavigationRouter {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @Provide viewModel: CurrencyViewModel = new CurrencyViewModel();
  @Provide allCurrencyData: CurrencyData[] = this.viewModel.initCurrencyData()
  @Provide selectedBaseCurrency: CurrencyData = this.viewModel.selectedBaseCurrency
  @Provide selectedTargetCurrency: CurrencyData = this.viewModel.selectedTargetCurrency
  @Provide baseAmount: string = '1.00';
  @Provide targetAmount: string = '';
  @Provide triggerMechanism: number = 1;

  aboutToAppear() {
    this.init()
  }

  init() {
    this.selectedBaseCurrency = this.viewModel.selectedBaseCurrency;
    this.selectedTargetCurrency = this.viewModel.selectedTargetCurrency;
    this.targetAmount = this.viewModel.calculateConversion(this.baseAmount);
    this.pageInfos.pushPathByName('SplashPage', null);
  }

  loadFonts() {

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'alipay_number', familySrc: $rawfile('fonts/alipayNumber.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'apcuicon_font', familySrc: $rawfile('fonts/apcuiconfont.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'arrow', familySrc: $rawfile('fonts/arrow.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'default', familySrc: $rawfile('fonts/default.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'default_demo', familySrc: $rawfile('fonts/default_demo.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'h5titlebar', familySrc: $rawfile('fonts/h5titlebar.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'iconfont', familySrc: $rawfile('fonts/iconfont.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({
        familyName: 'my_live_alibaba_sans_font',
        familySrc: $rawfile('fonts/my_live_alibaba_sans_font.ttf')
      })


    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'rouble', familySrc: $rawfile('fonts/rouble.otf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'sacramento', familySrc: $rawfile('fonts/sacramentoRegular.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'score', familySrc: $rawfile('fonts/score.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'speaker', familySrc: $rawfile('fonts/speaker.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'tinyicon', familySrc: $rawfile('fonts/tinyicon.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'titlebar', familySrc: $rawfile('fonts/titlebar.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'widget_forest', familySrc: $rawfile('fonts/widget_forest.ttf') })

    this.getUIContext()
      .getFont()
      .registerFont({ familyName: 'xfont', familySrc: $rawfile('fonts/x.ttf') })

  }

  @Builder
  routerMap(builderName: string, param: object) {
    if (builderName === 'SplashPage') {
      SplashPage()
    } else if (builderName === 'ExchangePage') {
      ExchangePage()
    } else if (builderName === 'SelectCurrencyPage') {
      SelectCurrencyPage()
    }
  }

  build() {
    Navigation(this.pageInfos) {
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.routerMap)
  }
}

