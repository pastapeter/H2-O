import { type State } from '@/providers/SelectionProvider/hooks/useSelectionReducer';

export const selectionInfo: State = {
  model: {
    id: 1,
    name: '팰리세이드',
    price: 0,
  },
  trim: {
    id: 2,
    name: 'Le Blanc',
    price: 38960000,
  },
  priceRange: { maxPrice: 54590000, minPrice: 38960000 },
  powerTrain: {
    id: 1,
    image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/powertrain/dieselengine2.2.jpg',
    name: '디젤 2.2',
    price: 1480000,
  },
  bodyType: {
    id: 1,
    image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/bodytype/7_seat.jpg',
    name: '7인승',
    price: 0,
  },
  driveTrain: {
    id: 1,
    image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/drivetrain/2wd.png',
    name: '2WD',
    price: 0,
  },
  exteriorColor: {
    colorCode: '#121929',
    id: 3,
    image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/trim/le-blanc/blue_exterior/image_001.png',
    name: '문라이트 블루 펄',
    price: 0,
  },
  interiorColor: {
    fabricImage: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/internal/colorchip-interior-black.png',
    id: 1,
    image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/internal/img-interior-black.png',
    name: '퀼팅 천연(블랙)',
    price: 0,
  },
  displacement: 2199,
  fuelEfficiency: 12.16,
  extraOptions: {
    optionList: [
      {
        id: 1,
        image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/package/roa.jpg',
        isPackage: true,
        isQuotation: false,
        name: '컴포트 Ⅱ',
        price: 1090000,
      },
      {
        id: 68,
        image: 'https://h2o-static-contents.s3.ap-northeast-2.amazonaws.com/option/builtincam.jpg',
        isPackage: false,
        isQuotation: false,
        name: '빌트인 캠(보조배터리 포함)',
        price: 690000,
      },
    ],
    price: 1780000,
  },
};

export const calculateTotalPrice = (selectionInfo: State) => {
  const { trim, powerTrain, bodyType, driveTrain, exteriorColor, interiorColor, extraOptions } = selectionInfo;
  const options = [trim, powerTrain, bodyType, driveTrain, exteriorColor, interiorColor, extraOptions];

  return options.reduce((acc, curr) => acc + (curr?.price || 0), 0);
};
