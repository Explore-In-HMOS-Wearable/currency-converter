@Builder
export function SplashPageBuilder(name: string, param: Object) {
  SplashPage()
}

@Component
export struct SplashPage {
  @Consume('pageInfos') pageInfos: NavPathStack;
  controller: TextClockController = new TextClockController()

  aboutToAppear(): void {
    setTimeout(() => {
      this.pageInfos.pushPathByName('ExchangePage', null);
    }, 2000)
  }

  build() {
    NavDestination() {
      Column() {
        Stack() {
          Image($r('app.media.splash_bg'))
          Stack() {
            Image($r('app.media.logo'))
              .width('75%')
              .align(Alignment.Center)
              .borderWidth(0)
              .margin({ top: '14vp' })
            Column() {
              Column() {
                Blank().height('25vp')
                Text($r('app.string.splash_text'))
                  .width('180%')
                  .fontSize(17)
                  .fontWeight(FontWeight.Bolder)
                  .fontFamily('default')
                  .textAlign(TextAlign.Center)
              }
              .width($r('app.string.w_100'))
            }
            .height('90%')
            .width('40%')
          }
          .height('70%')
        }
        .width($r('app.string.navDestination_width'))
        .height($r('app.string.navDestination_height'))
        .alignContent(Alignment.Center)
      }
      .width($r('app.string.navDestination_width'))
      .height($r('app.string.navDestination_height'))
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
    })
  }
}
