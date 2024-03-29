import { useReducer } from 'react';
import type { TechnicalSpecResponse } from '@/types/response';
import type {
  ExteriorColorInfo,
  ExtraOptionsInfo,
  InteriorColorInfo,
  OptionInfo,
  PriceRangeInfo,
  SelectionInfo,
  SelectionInfoWithImage,
} from '@/providers/SelectionProvider/types';

export type State = {
  model: SelectionInfo;
  trim?: SelectionInfo;
  priceRange?: PriceRangeInfo;
  powerTrain?: SelectionInfoWithImage;
  bodyType?: SelectionInfoWithImage;
  driveTrain?: SelectionInfoWithImage;
  exteriorColor?: ExteriorColorInfo;
  interiorColor?: InteriorColorInfo;
  displacement?: number;
  fuelEfficiency?: number;
  extraOptions?: ExtraOptionsInfo;
};

export type Action =
  | { type: 'SET_TRIM'; payload: SelectionInfo }
  | { type: 'SET_PRICE_RANGE'; payload: PriceRangeInfo }
  | { type: 'SET_POWER_TRAIN'; payload: SelectionInfoWithImage }
  | { type: 'SET_BODY_TYPE'; payload: SelectionInfoWithImage }
  | { type: 'SET_DRIVE_TRAIN'; payload: SelectionInfoWithImage }
  | { type: 'SET_EXTERIOR_COLOR'; payload: ExteriorColorInfo }
  | { type: 'SET_INTERIOR_COLOR'; payload: InteriorColorInfo }
  | { type: 'SET_DISPLACEMENT_AND_FUEL_EFFICIENCY'; payload: TechnicalSpecResponse }
  | { type: 'SET_EXTRA_OPTIONS'; payload: OptionInfo[] };

const initialState: State = {
  model: {
    id: 1,
    name: '팰리세이드',
    price: 0,
  },
  trim: undefined,
  priceRange: undefined,
  powerTrain: undefined,
  bodyType: undefined,
  driveTrain: undefined,
  exteriorColor: undefined,
  interiorColor: undefined,
  displacement: undefined,
  fuelEfficiency: undefined,
  extraOptions: undefined,
};

const reducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'SET_TRIM':
      return {
        ...state,
        trim: {
          ...state.trim,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
        },
      };
    case 'SET_PRICE_RANGE': {
      return {
        ...state,
        priceRange: {
          ...state.priceRange,
          minPrice: action.payload.minPrice,
          maxPrice: action.payload.maxPrice,
        },
      };
    }
    case 'SET_POWER_TRAIN':
      return {
        ...state,
        powerTrain: {
          ...state.powerTrain,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
          image: action.payload.image,
        },
      };
    case 'SET_BODY_TYPE':
      return {
        ...state,
        bodyType: {
          ...state.bodyType,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
          image: action.payload.image,
        },
      };
    case 'SET_DRIVE_TRAIN':
      return {
        ...state,
        driveTrain: {
          ...state.driveTrain,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
          image: action.payload.image,
        },
      };
    case 'SET_EXTERIOR_COLOR':
      return {
        ...state,
        exteriorColor: {
          ...state.exteriorColor,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
          image: action.payload.image,
          colorCode: action.payload.colorCode,
        },
      };
    case 'SET_INTERIOR_COLOR':
      return {
        ...state,
        interiorColor: {
          ...state.interiorColor,
          id: action.payload.id,
          name: action.payload.name,
          price: action.payload.price,
          image: action.payload.image,
          fabricImage: action.payload.fabricImage,
        },
      };
    case 'SET_DISPLACEMENT_AND_FUEL_EFFICIENCY':
      return {
        ...state,
        displacement: action.payload.displacement,
        fuelEfficiency: action.payload.fuelEfficiency,
      };
    case 'SET_EXTRA_OPTIONS':
      return {
        ...state,
        extraOptions: {
          price: action.payload.reduce((acc, curr) => acc + (curr?.price || 0), 0),
          optionList: action.payload,
        },
      };
    default:
      return state;
  }
};

function useSelectionReducer() {
  return useReducer(reducer, initialState);
}

export default useSelectionReducer;
