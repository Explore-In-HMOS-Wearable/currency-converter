import { CurrencyItem } from '../view/CurrencyItem';
import { SearchBar } from '../view/SearchBar';
import { CurrencyData } from '../viewmodel/CurrencyData';
import { CurrencyViewModel } from '../viewmodel/CurrencyViewModel';
import { TmpClass } from './ExchangePage';

@Builder
export function SelectCurrencyPageBuilder(name: string, param: Object) {
  SelectCurrencyPage()
}

@Component
export struct SelectCurrencyPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State searchResult: CurrencyData[] = [];
  @State searchQuery: string = '';
  @State currentCurrencyType: string = '';
  @State currentCurrencyCode: string = 'TRY';
  @Consume viewModel: CurrencyViewModel;
  @Consume selectedBaseCurrency: CurrencyData
  @Consume selectedTargetCurrency: CurrencyData
  @Consume triggerMechanism: number

  aboutToAppear() {
    this.init()
  }

  onPageShow(): void {
    this.init()
  }

  init() {
    this.searchResult = this.viewModel.getCurrencyData();
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Blank().width("16%")
          Column() {
            Image($r('app.media.ic_arrow_left'))
              .width(25)
              .height(25)
              .margin({ top: "19vp" })
              .onClick(() => {
                this.triggerMechanism++;
                this.pageInfos.pop()
              })
          }
          .alignSelf(ItemAlign.Center)
          .width(25)

          SearchBar({
            placeholder: this.getUIContext().getHostContext()?.resourceManager.getStringSync($r('app.string.search').id),
            color: $r('app.color.updated_bg'),
            onSearch: (value: string) => {
              this.searchQuery = value;
              this.searchResult = this.viewModel.searchCurrency(value);
            }
          })
        }
        .alignItems(VerticalAlign.Bottom)
        .height("60vp")
        .width($r('app.string.w_100'))

        List() {
          ForEach(this.searchResult, (currencyData: CurrencyData) => {
            ListItem() {
              CurrencyItem({
                currency: currencyData,
                isSelected: currencyData.code == this.currentCurrencyCode,
                onItemClick: (currency: CurrencyData) => {
                  if (this.currentCurrencyType === 'base') {
                    this.viewModel.selectedBaseCurrency = currency;
                    this.selectedBaseCurrency = currency
                  } else if (this.currentCurrencyType === 'target') {
                    this.viewModel.selectedTargetCurrency = currency;
                    this.selectedTargetCurrency = currency
                  }
                  this.pageInfos.pop()
                }
              })
            }
          }, (item: CurrencyData, index: number) => item.name)

          ListItem() {
            Text($r('app.string.blank'))
              .visibility(Visibility.Hidden)
              .height('55vp')
          }
        }
        .backgroundColor(Color.White)
        .layoutWeight(1)
        .width($r('app.string.w_100'))
      }
      .height($r('app.string.w_100'))
      .width($r('app.string.w_100'))
      .backgroundColor($r('app.color.currency_bg'))
      .alignItems(HorizontalAlign.Center)

    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      this.currentCurrencyType = (context.pathInfo.param as TmpClass).currencyType
      this.currentCurrencyCode = (context.pathInfo.param as TmpClass).currencyCode
    })

  }
}