export class CurrencyData {
  code: string = '';
  name: string = '';
  flag: Resource;
  symbol: string = '';
  rate: number = 1.0;
  isSelected = false;

  constructor(code: string, name: string, flag: Resource, symbol: string, rate: number = 1.0, isSelected = false) {
    this.code = code;
    this.name = name;
    this.flag = flag;
    this.symbol = symbol;
    this.rate = rate;
    this.isSelected = isSelected
  }
}

export interface CurrencyRates {
  amount: number;
  base: string;
  date: string;
  rates: Rate[];
}

export interface Rate {
  code: number;
}