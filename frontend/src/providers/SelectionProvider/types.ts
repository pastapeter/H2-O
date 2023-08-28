export interface SelectionInfo {
  id: number;
  name: string;
  price: number;
}

export interface PriceRangeInfo {
  minPrice: number;
  maxPrice: number;
}

export interface SelectionInfoWithImage extends SelectionInfo {
  image: string;
}

export interface ExteriorColorInfo extends SelectionInfoWithImage {
  colorCode: string;
}

export interface InteriorColorInfo extends SelectionInfoWithImage {
  fabricImage: string;
}

export interface OptionInfo extends SelectionInfoWithImage {
  isPackage: boolean;
  isQuotation: boolean;
}

export interface ExtraOptionsInfo {
  price: number;
  optionList: OptionInfo[];
}
