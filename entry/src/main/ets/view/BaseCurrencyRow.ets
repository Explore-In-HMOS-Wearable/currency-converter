import { CurrencyData } from '../viewmodel/CurrencyData';

@Component
export struct BaseCurrencyRow {
  @Prop amount: string = '';
  @State inputAmount: string = '';
  onAmountChange?: (value: string) => void;
  onCurrencySelect?: () => void;
  @Consume selectedBaseCurrency: CurrencyData

  aboutToAppear() {
    this.init()
  }

  onPageShow(): void {
    this.init()
  }

  init() {
    this.inputAmount = this.amount;
  }

  build() {
    Row() {
      Row() {
        // Currency flag
        Image(this.selectedBaseCurrency.flag)
          .width(20)
          .height(20)
          .borderRadius(4)
          .margin({ right: 12 })

        Text(this.selectedBaseCurrency.code)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .width('27.00vp')
          .fontColor(Color.Black)

        Image($r('app.media.ic_arrow_right'))
          .width(12)
          .height(12)
          .margin({ left: 6, right: 6 })

      }
      .onClick(() => {
        if (this.onCurrencySelect) {
          this.onCurrencySelect();
        }
      })

      TextInput({
        text: this.inputAmount,
        placeholder: $r('app.string.enter')
      })
        .layoutWeight(1)
        .type(InputType.NUMBER_DECIMAL)
        .textAlign(TextAlign.Start)
        .fontSize(19)
        .height(`35vp`)
        .backgroundColor($r(`app.color.inputBackground`))
        .padding({ left: 17, right: 0 })
        .fontWeight(FontWeight.Bold)
        .placeholderColor(Color.White)
        .placeholderFont({
          size: 15,
          weight: FontWeight.Bold
        })
        .onChange((value: string) => {
          this.inputAmount = value;
          if (this.onAmountChange) {
            this.onAmountChange(value);
          }
        })

    }
    .width($r('app.string.w_100'))
    .height(`45vp`)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 16,
      right: 16,
      top: 12,
      bottom: 12
    })
  }
}