import { ChangeEventHandler, useReducer } from 'react';
import { HASHTAG_LIST, defaultOptionCategoryList, extraOptionCategoryList } from '../mock/mock';
import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';

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
  | { type: 'CLICK_SEARCH_BUTTON' };

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

const filterExtraOption = (input: string, entireList: ExtraOptionResponse[]) => {
  if (extraOptionCategoryList.includes(input)) return entireList.filter((option) => option.category === input);
  if (HASHTAG_LIST.includes(input)) return entireList.filter((option) => option.hashTags.includes(input));
  return entireList.filter((option) => option.name.includes(input));
};

const filterDefaultOption = (input: string, entireList: DefaultOptionResponse[]) => {
  if (defaultOptionCategoryList.includes(input)) return entireList.filter((option) => option.category === input);
  return entireList.filter((option) => option.name.includes(input));
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
      return {
        ...state,
        extraOptionList: state.isExtraOption
          ? filterExtraOption(action.payload, state.extraOptionEntireList)
          : state.extraOptionList,
        defaultOptionList: state.isExtraOption
          ? state.defaultOptionList
          : filterDefaultOption(action.payload, state.defaultOptionEntireList),
        input: action.payload,
      };
    case 'CLICK_SEARCH_BUTTON':
      return {
        ...state,
        extraOptionList: state.isExtraOption
          ? filterExtraOption(state.input, state.extraOptionEntireList)
          : state.extraOptionList,
        defaultOptionList: state.isExtraOption
          ? state.defaultOptionList
          : filterDefaultOption(state.input, state.defaultOptionEntireList),
        input: '',
      };
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

  const handleChangeInput: ChangeEventHandler<HTMLInputElement> = (e) =>
    dispatch({ type: 'CHANGE_INPUT', payload: e.target.value });

  const handleClickSearchButton = () => dispatch({ type: 'CLICK_SEARCH_BUTTON' });

  return {
    state,
    setOptionList,
    handleClickExtraOption,
    handleClickDefaultOption,
    handleClickExtraCategory,
    handleClickDefaultCategory,
    handleChangeInput,
    handleClickSearchButton,
  } as const;
}

export default useFilter;
