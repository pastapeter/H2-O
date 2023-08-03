export const COLORS = {
  // primary
  primary100: '#CCD7E5',
  primary200: '#99B0CA',
  primary300: '#6688B0',
  primary400: '#336196',
  primary500: '#00397B',
  primary600: '#002E63',
  primary700: '#00224A',
  primary800: '#001731',
  primary900: '#000B19',

  // white
  white: '#FFFFFF',

  // grayscale
  gray50: '#F7F8F9',
  gray100: '#EDEDEE',
  gray200: '#DADCDD',
  gray300: '#C8CACC',
  gray400: '#B6B8BB',
  gray500: '#A3A6AA',
  gray600: '#838588',
  gray700: '#626466',
  gray800: '#414344',
  gray900: '#212122',

  // other colors
  activeBlue: '#00AAD2',
  activeBlue2: '#00C3F0',
  skyBlue: '#A2C7E7',
  skyBlueCardBg: '#A2C7E74D',
  cardBg: '#00AAD21A',
  blueBg: '#F4F5F7',
  sand: '#B67B5E',
  sand2: '#E4DCD3',
  lightSand: '#F6F3F2',
} as const;

export type ColorType = typeof COLORS;
export type Colors = keyof ColorType;
