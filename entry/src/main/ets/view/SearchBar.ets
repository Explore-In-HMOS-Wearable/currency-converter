@Component
export struct SearchBar {
  @Prop placeholder: string = '';
  @Prop color: string|Resource
  onSearch: (type: string) => void = () => {
  };

  build() {
    Search({ placeholder: this.placeholder })
      .searchIcon({
        src: $r('app.media.ic_search')
      })
      .placeholderColor($r('app.color.search_placeholder'))
      .placeholderFont({ style: FontStyle.Normal, size: '14vp'})
      .fontColor($r('app.color.search_font'))
      .width('55%')
      .height('35vp')
      .backgroundColor(this.color)
      .borderRadius(4)
      .onChange((value: string) => {
        this.onSearch(value)
      })
      .onSubmit((value: string) => {
        this.onSearch(value)
      })
  }
}

