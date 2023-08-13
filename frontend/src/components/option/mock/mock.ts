import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';

export const HASHTAG_LIST = [
  '스마트',
  '주차/출차',
  '초보운전',
  '레저',
  '안전',
  '자녀',
  '반려동물',
  '쾌적',
  '스타일',
  '장거리운전',
  '고속도로',
  '다인가족',
  '국내여행',
  '캠핑',
];

export const extraOptionCategoryList = ['전체', '상세품목', '악세사리', '휠'];
export const defaultOptionCategoryList = [
  '전체',
  '파워트레인/성능',
  '지능형 안전기술',
  '안전',
  '외관',
  '내장',
  '시트',
  '편의',
  '멀티미디어',
];

export const EXTRA_OPTION_LIST: ExtraOptionResponse[] = [
  {
    id: 0,
    category: '상세품목',
    name: '컴포트II',
    image: '/images/exterior2.png',
    isPackage: true,
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
    choiceRatio: 38,
    price: 350000,
  },
  {
    id: 1,
    category: '악세사리',
    name: '2열 통풍',
    image: '/images/interior.png',
    isPackage: false,
    hashTags: ['자녀', '스마트', '초보운전'],
    containsHmgData: true,
    choiceRatio: 38,
    price: 350000,
  },
  {
    id: 2,
    category: '휠',
    name: '컴포트II',
    image: '/images/exterior2.png',
    isPackage: true,
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
    choiceRatio: 38,
    price: 350000,
  },
  {
    id: 3,
    category: '상세품목',
    name: '컴포트II',
    image: '/images/interior.png',
    isPackage: false,
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
    choiceRatio: 38,
    price: 350000,
  },
  {
    id: 4,
    category: '악세사리',
    name: '컴포트II',
    image: '/images/interior.png',
    isPackage: false,
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
    choiceRatio: 38,
    price: 350000,
  },
];

export const DEFAULT_OPTION_LIST: DefaultOptionResponse[] = [
  {
    id: 5,
    category: '지능형 안전기술',
    name: '차로 이탈방지 보조',
    image: '/images/exterior2.png',
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
  },
  {
    id: 6,
    category: '안전',
    name: '2열 통풍',
    image: '/images/interior.png',
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
  },
  {
    id: 7,
    category: '외관',
    name: '차로 이탈방지 보조',
    image: '/images/exterior2.png',
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
  },
  {
    id: 8,
    category: '내장',
    name: '2열 통풍',
    image: '/images/interior.png',
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: true,
  },
  {
    id: 9,
    category: '파워트레인/성능',
    name: '2열 통풍',
    image: '/images/interior.png',
    hashTags: ['장거리운전', '스마트', '초보운전'],
    containsHmgData: false,
  },
];

export const DETAILED_OPTION_LIST = [
  {
    name: '빌트인 캠1',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '컴포트 II',
    category: '상세품목',
    hashTags: ['장거리운전', '다자녀', '안전'],
    components: [
      {
        name: '후석 승객 알림',
        category: '지능형 안전기술',
        image: '/images/disel.png',
        description:
          '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
        hmgData: {
          overHalf: true,
          choiceCount: 2384,
          useCount: 73.2,
        },
        price: 400000,
      },
      {
        name: '메탈 리어범퍼스텝',
        category: '지능형 안전기술',
        image: '/images/wheel.png',
        description:
          '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
        hmgData: {
          overHalf: true,
          choiceCount: 2384,
          useCount: 73.2,
        },
        price: 400000,
      },
      {
        name: '메탈 도어스커프',
        category: '지능형 안전기술',
        image: '/images/disel.png',
        description:
          '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
        hmgData: {
          overHalf: true,
          choiceCount: 2384,
          useCount: 73.2,
        },
        price: 400000,
      },
      {
        name: '3열파워폴딩시트',
        category: '지능형 안전기술',
        image: '/images/disel.png',
        description:
          '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
        hmgData: {
          overHalf: true,
          choiceCount: 2384,
          useCount: 73.2,
        },
        price: 400000,
      },
      {
        name: '후석 승객 알림',
        category: '지능형 안전기술',
        image: '/images/disel.png',
        description:
          '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
        hmgData: {
          overHalf: true,
          choiceCount: 2384,
          useCount: 73.2,
        },
        price: 400000,
      },
    ],
  },
  {
    name: '빌트인 캠2',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠3',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠4',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠5',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠6',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠7',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠8',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
  {
    name: '빌트인 캠9',
    category: '상세품목',
    image: '/images/disel.png',
    hashTags: ['장거리운전', '안전', '주차/출차'],
    description:
      '시동이 걸린 상태에서 해당 좌석의 통풍 스위치를 누르면 표시등이 켜지면서 해당 좌석에 바람이 나오는 편의장치입니다.',
    hmgData: {
      overHalf: true,
      choiceCount: 2384,
      useCount: 73.2,
    },
  },
];
