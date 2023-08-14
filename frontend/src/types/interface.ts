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

export interface DetailedOptionResponse {
  name: string;
  category: string;
  image: string;
  hashTags?: string[];
  description: string;
  hmgData: {
    overHalf: boolean;
    choiceCount: number;
    useCount: number;
  };
  price?: number;
}

export interface DetailedPackageOptionResponse {
  name: string;
  category: string;
  hashTags: string[];
  components: DetailedOptionResponse[];
}
