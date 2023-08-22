export interface TrimOption {
  dataLabel: string;
  frequency: number;
}

export interface TrimResponse {
  id: number;
  name: string;
  description: string;
  price: number;
  images: string[];
  options: TrimOption[];
}

export interface TrimPriceRangeResponse {
  maxPrice: number;
  minPrice: number;
}

export interface TrimPriceDistributionResponse {
  unit: number;
  quantityPerUnit: number[];
}

export interface MaxOutput {
  output: number;
  minRpm: number;
  maxRpm: number;
}

export interface MaxTorque {
  torque: number;
  minRpm: number;
  maxRpm: number;
}

export interface PowerTrain {
  id: number;
  name: string;
  price: number;
  choiceRatio: number;
  description: string;
  maxOutput: MaxOutput;
  maxTorque: MaxTorque;
  image: string;
}

export interface BodyType {
  id: number;
  name: string;
  price: number;
  choiceRatio: number;
  description: string;
  image: string;
}

export interface DriveTrain {
  id: number;
  name: string;
  price: number;
  choiceRatio: number;
  description: string;
  image: string;
}

export interface ModelTypeResponse {
  powertrains: PowerTrain[];
  bodytypes: BodyType[];
  drivetrains: DriveTrain[];
}

export interface TechnicalSpecResponse {
  displacement: number;
  fuelEfficiency: number;
}

export interface ExteriorColorResponse {
  id: number;
  name: string;
  choiceRatio: number;
  price: number;
  hexCode: string;
  images: string[];
}

export interface InteriorColorResponse {
  id: number;
  name: string;
  choiceRatio: number;
  price: number;
  fabricImage: string;
  bannerImage: string;
}

export interface DefaultOptionResponse {
  id: number;
  category: string;
  name: string;
  image: string;
  hashTags: string[];
  containsHmgData: boolean;
}

export interface ExtraOptionResponse extends DefaultOptionResponse {
  isPackage: boolean;
  choiceRatio: number;
  price: number;
}

export interface GeneralOptionResponse {
  name: string;
  category: string;
  description?: string;
  hashTags?: string[];
  image: string;
  price?: number;
  containsChoiceCount: boolean;
  containsUseCount: boolean;
  hmgData: {
    choiceCount: number;
    overHalf: boolean;
    useCount?: number;
  };
}

export interface PackageOptionResponse {
  name: string;
  category: string;
  choiceCount: number;
  choiceRatio: number;
  hashTags?: string[];
  isOverHalf: boolean;
  price?: number;
  components?: [
    {
      name: string;
      category: string;
      containsHmgData: boolean;
      description: string;
      hashTags?: string[];
      image: string;
      useCount?: number;
    },
  ];
}

export interface QutationBody {
  carId: number;
  externalColorId: number;
  internalColorId: number;
  modelTypeIds: {
    bodytypeId: number;
    drivetrainId: number;
    powertrainId: number;
  };
  optionIds: number[];
  packageIds: number[];
  trimId: number;
}

export interface QuotationOption {
  category: string;
  id: number;
  image: string;
  name: string;
  price: number;
}

export interface QutationResponse {
  image: string;
  modelType: {
    bodytypeName: string;
    drivetrainName: string;
    powertrainName: string;
  };
  options: QuotationOption[];
  price: number;
  salesCount: number;
}

export interface SalesCountResponse {
  salesCount: number;
}
