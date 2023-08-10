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

export interface InteriorColorResponse {
  id: number;
  name: string;
  choiceRatio: number;
  price: number;
  fabricImage: string;
  bannerImage: string;
}
