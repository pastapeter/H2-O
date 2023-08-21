import { useCallback, useReducer } from 'react';
import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';
import { HASHTAG_LIST, defaultOptionCategoryList, extraOptionCategoryList } from '@/components/option/constants';

type Action =
  | {
      type: 'SET_OPTION_LIST';
      payload: { extraOptionList: ExtraOptionResponse[]; defaultOptionList: DefaultOptionResponse[] };
    }
  | { type: 'CLICK_EXTRA_OPTION' }
  | { type: 'CLICK_DEFAULT_OPTION' }
  | { type: 'CLICK_EXTRA_CATEGORY'; payload: number }
  | { type: 'CLICK_DEFAULT_CATEGORY'; payload: number }
  | { type: 'CHANGE_INPUT'; payload: string }
  | { type: 'SET_EXTRA_OPTION_LIST'; payload: ExtraOptionResponse[] }
  | { type: 'SET_DEFAULT_OPTION_LIST'; payload: DefaultOptionResponse[] };

type State = {
  isExtraOption: boolean;
  extraCategoryIdx: number;
  defaultCategoryIdx: number;
  extraOptionList: ExtraOptionResponse[];
  defaultOptionList: DefaultOptionResponse[];
  extraOptionEntireList: ExtraOptionResponse[];
  defaultOptionEntireList: DefaultOptionResponse[];
  input: string;
};

interface ExtraFilterProps {
  input: string;
  entireList: ExtraOptionResponse[];
}

interface DefaultFilterProps {
  input: string;
  entireList: DefaultOptionResponse[];
}

const filterExtraOption = ({ input, entireList }: ExtraFilterProps) => {
  if (extraOptionCategoryList.includes(input)) return entireList.filter((option) => option.category === input);
  if (HASHTAG_LIST.includes(input)) return entireList.filter((option) => option.hashTags.includes(input));
  return entireList.filter((option) => option.name.includes(input));
};

const filterDefaultOption = ({ input, entireList }: DefaultFilterProps) => {
  if (defaultOptionCategoryList.includes(input)) return entireList.filter((option) => option.category === input);
  return entireList.filter((option) => option.name.includes(input));
};

const debounceFunction = <T extends unknown[]>(callback: (...args: T) => void, delay: number) => {
  let timer: NodeJS.Timeout;

  return (...args: T) => {
    clearTimeout(timer);
    timer = setTimeout(() => callback(...args), delay);
  };
};

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case 'SET_OPTION_LIST':
      return {
        ...state,
        extraOptionList: action.payload.extraOptionList,
        extraOptionEntireList: action.payload.extraOptionList,
        defaultOptionList: action.payload.defaultOptionList,
        defaultOptionEntireList: action.payload.defaultOptionList,
      };
    case 'CLICK_EXTRA_OPTION':
      return { ...state, isExtraOption: true };
    case 'CLICK_DEFAULT_OPTION':
      return { ...state, isExtraOption: false };
    case 'CLICK_EXTRA_CATEGORY':
      return {
        ...state,
        extraCategoryIdx: action.payload,
        extraOptionList: action.payload
          ? state.extraOptionEntireList.filter((opt) => opt.category === extraOptionCategoryList[action.payload])
          : state.extraOptionEntireList,
      };
    case 'CLICK_DEFAULT_CATEGORY':
      return {
        ...state,
        defaultCategoryIdx: action.payload,
        defaultOptionList: action.payload
          ? state.defaultOptionEntireList.filter((opt) => opt.category === defaultOptionCategoryList[action.payload])
          : state.defaultOptionEntireList,
      };
    case 'CHANGE_INPUT':
      return { ...state, input: action.payload };
    case 'SET_EXTRA_OPTION_LIST':
      return { ...state, extraOptionList: action.payload };
    case 'SET_DEFAULT_OPTION_LIST': {
      return { ...state, defaultOptionList: action.payload };
    }

    default:
      throw new Error('옵션 선택 action error');
  }
}

function useFilter() {
  const initState: State = {
    isExtraOption: true,
    extraCategoryIdx: 0,
    defaultCategoryIdx: 0,
    extraOptionList: [],
    extraOptionEntireList: [],
    defaultOptionList: [],
    defaultOptionEntireList: [],
    input: '',
  };

  const [state, dispatch] = useReducer(reducer, initState);

  const setOptionList = (extraOptionList: ExtraOptionResponse[], defaultOptionList: DefaultOptionResponse[]) =>
    dispatch({ type: 'SET_OPTION_LIST', payload: { extraOptionList, defaultOptionList } });

  const handleClickExtraOption = () => dispatch({ type: 'CLICK_EXTRA_OPTION' });

  const handleClickDefaultOption = () => dispatch({ type: 'CLICK_DEFAULT_OPTION' });

  const handleClickExtraCategory = (categoryIdx: number) => () =>
    dispatch({ type: 'CLICK_EXTRA_CATEGORY', payload: categoryIdx });

  const handleClickDefaultCategory = (categoryIdx: number) => () =>
    dispatch({ type: 'CLICK_DEFAULT_CATEGORY', payload: categoryIdx });

  const searchExtraOption = useCallback(
    debounceFunction(
      (props: ExtraFilterProps) => dispatch({ type: 'SET_EXTRA_OPTION_LIST', payload: filterExtraOption(props) }),
      300,
    ),
    [],
  );

  const searchDefaultOption = useCallback(
    debounceFunction(
      (props: DefaultFilterProps) => dispatch({ type: 'SET_DEFAULT_OPTION_LIST', payload: filterDefaultOption(props) }),
      300,
    ),
    [],
  );

  const handleChangeInput = (value: string) => {
    state.isExtraOption
      ? searchExtraOption({ input: value, entireList: state.extraOptionEntireList })
      : searchDefaultOption({ input: value, entireList: state.defaultOptionEntireList });
    dispatch({ type: 'CHANGE_INPUT', payload: value });
  };

  return {
    state,
    setOptionList,
    handleClickExtraOption,
    handleClickDefaultOption,
    handleClickExtraCategory,
    handleClickDefaultCategory,
    handleChangeInput,
  } as const;
}

export default useFilter;
