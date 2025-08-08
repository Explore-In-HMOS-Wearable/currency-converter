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

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()


    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

    this.getUIContext()
      .getFont()

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

