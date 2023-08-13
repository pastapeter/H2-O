export interface TrimOption {
  dataLabel: string;
  frequency: number;
}

export interface Trim {
  id: number;
  name: string;
  description: string;
  price: number;
  images: string[];
  options: TrimOption[];
}

export interface TrimResponse {
  trims: Trim[];
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
  powerTrains: PowerTrain[];
  bodyTypes: BodyType[];
  driveTrains: DriveTrain[];
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
