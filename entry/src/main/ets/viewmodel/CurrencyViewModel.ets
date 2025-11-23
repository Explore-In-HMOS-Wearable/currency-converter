import { CurrencyData, CurrencyRates } from './CurrencyData';
import { rcp } from '@kit.RemoteCommunicationKit';

const API_BASE_URL = 'https://' + $r('app.string.core_url');
const session = rcp.createSession();

@Observed
export class CurrencyViewModel {
  private allCurrencyData: CurrencyData[] = [];

  constructor() {
    this.allCurrencyData = this.initCurrencyData();
    this._selectedBaseCurrency = this.allCurrencyData[0]; // USD
    this._selectedTargetCurrency = this.allCurrencyData[1]; // EUR
    this.fetchAndUpdateRates()
  }

  private _selectedBaseCurrency: CurrencyData;

  // Getters and setters for selected currencies
  get selectedBaseCurrency(): CurrencyData {
    return this._selectedBaseCurrency;
  }

  set selectedBaseCurrency(currency: CurrencyData) {
    this._selectedBaseCurrency = currency;
  }

  private _selectedTargetCurrency: CurrencyData;

  get selectedTargetCurrency(): CurrencyData {
    return this._selectedTargetCurrency;
  }

  set selectedTargetCurrency(currency: CurrencyData) {
    this._selectedTargetCurrency = currency;
  }

  // Initialize currency data
  public initCurrencyData(): CurrencyData[] {
    return [
      new CurrencyData('USD', 'US Dollar',
        $r('app.media.flag_usd'), '$', 1.0),
      new CurrencyData('EUR', 'Euro', $r('app.media.flag_eur'), '€',
        0.92),
      new CurrencyData('GBP', 'British Pound',
        $r('app.media.flag_gbp'), '£', 0.77),
      new CurrencyData('JPY', 'Japanese Yen',
        $r('app.media.flag_jpy'), '¥', 151.23),
      new CurrencyData('TRY', 'Turkish Lira',
        $r('app.media.flag_try'), '₺', 32.45),
      new CurrencyData('CAD', 'Canadian Dollar',
        $r('app.media.flag_cad'), 'C$', 1.34),
      new CurrencyData('CHF', 'Swiss Franc',
        $r('app.media.flag_chv'), 'CHF', 0.90),
      new CurrencyData('CNY', 'Chinese Yuan',
        $r('app.media.flag_cny'), '¥', 7.18),
      new CurrencyData('INR', 'Indian Rupee',
        $r('app.media.flag_inr'), '₹', 82.96),
      new CurrencyData('BRL', 'Brazilian Real',
        $r('app.media.flag_brl'), 'R$', 5.04),
      new CurrencyData('MXN', 'Mexican Peso',
        $r('app.media.flag_mxn'), '$', 17.27),
      new CurrencyData('ZAR', 'South African Rand',
        $r('app.media.flag_zar'), 'R', 18.56),
      new CurrencyData('KRW', 'South Korean Won',
        $r('app.media.flag_krw'), '₩', 1310.50),
      new CurrencyData('RUB', 'Russian Ruble',
        $r('app.media.flag_rub'), '₽', 92.76),
    ];
  }

  // Get all currency data
  getCurrencyData(): CurrencyData[] {
    return this.allCurrencyData;
  }

  // Search for currencies by name or code
  searchCurrency(query: string): CurrencyData[] {
    if (!query || query.trim() === '') {
      return this.allCurrencyData;
    }

    const searchQuery = query.toLowerCase().trim();

    return this.allCurrencyData.filter(currency =>
    currency.name.toLowerCase().includes(searchQuery) ||
    currency.code.toLowerCase().includes(searchQuery)
    );
  }

  // Get currency by code
  getCurrencyByCode(code: string): CurrencyData | undefined {
    return this.allCurrencyData.find(c => c.code === code);
  }

  // Calculate conversion
  calculateConversion(amount: string): string {
    if (!amount || isNaN(parseFloat(amount))) {
      return '0.00';
    }

    const rate = this._selectedTargetCurrency.rate / this._selectedBaseCurrency.rate;
    const convertedAmount = parseFloat(amount) * rate;
    return convertedAmount.toFixed(4);
  }

  async fetchAndUpdateRates(): Promise<void> {
    const baseCode = 'USD'; // all calculation indexed to USD
    const url = `${API_BASE_URL}/latest?from=${baseCode}`;
    const request = new rcp.Request(url, 'GET');

    try {
      const response = await session.fetch(request);
      const currencyRates: CurrencyRates = response.toJSON() as CurrencyRates;

      this.allCurrencyData.forEach((currency) => {
        if (currency.code === baseCode) {
          currency.rate = 1.0;
        } else {
          currency.rate = currencyRates.rates[currency.code] || 0;
        }
      });

    } catch (err) {
      console.info('An error occurred.')
    }
  }
}
