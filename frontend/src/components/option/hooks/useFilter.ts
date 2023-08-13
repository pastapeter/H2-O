import { ChangeEventHandler, useReducer } from 'react';
import {
  DEFAULT_OPTION_LIST,
  EXTRA_OPTION_LIST,
  HASHTAG_LIST,
  defaultOptionCategoryList,
  extraOptionCategoryList,
} from '../mock/mock';
import type { DefaultOptionResponse, ExtraOptionResponse } from '@/types/interface';

type Action =
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
  input: string;
};

const initState: State = {
  isExtraOption: true,
  extraCategoryIdx: 0,
  defaultCategoryIdx: 0,
  extraOptionList: EXTRA_OPTION_LIST,
  defaultOptionList: DEFAULT_OPTION_LIST,
  input: '',
};

const filterExtraOption = (input: string) => {
  if (extraOptionCategoryList.includes(input)) return EXTRA_OPTION_LIST.filter((option) => option.category === input);
  if (HASHTAG_LIST.includes(input)) return EXTRA_OPTION_LIST.filter((option) => option.hashTags.includes(input));
  return EXTRA_OPTION_LIST.filter((option) => option.name.includes(input));
};

const filterDefaultOption = (input: string) => {
  if (defaultOptionCategoryList.includes(input))
    return DEFAULT_OPTION_LIST.filter((option) => option.category === input);
  if (HASHTAG_LIST.includes(input)) return DEFAULT_OPTION_LIST.filter((option) => option.hashTags.includes(input));
  return DEFAULT_OPTION_LIST.filter((option) => option.name.includes(input));
};

function reducer(state: State, action: Action): State {
  switch (action.type) {
    case 'CLICK_EXTRA_OPTION':
      return { ...state, isExtraOption: true };
    case 'CLICK_DEFAULT_OPTION':
      return { ...state, isExtraOption: false };
    case 'CLICK_EXTRA_CATEGORY':
      return {
        ...state,
        extraCategoryIdx: action.payload,
        extraOptionList: action.payload
          ? EXTRA_OPTION_LIST.filter((opt) => opt.category === extraOptionCategoryList[action.payload])
          : EXTRA_OPTION_LIST,
      };
    case 'CLICK_DEFAULT_CATEGORY':
      return {
        ...state,
        defaultCategoryIdx: action.payload,
        defaultOptionList: action.payload
          ? DEFAULT_OPTION_LIST.filter((opt) => opt.category === defaultOptionCategoryList[action.payload])
          : DEFAULT_OPTION_LIST,
      };
    case 'CHANGE_INPUT':
      return {
        ...state,
        extraOptionList: state.isExtraOption ? filterExtraOption(action.payload) : state.extraOptionList,
        defaultOptionList: state.isExtraOption ? state.defaultOptionList : filterDefaultOption(action.payload),
        input: action.payload,
      };
    case 'CLICK_SEARCH_BUTTON':
      return {
        ...state,
        extraOptionList: state.isExtraOption ? filterExtraOption(state.input) : state.extraOptionList,
        defaultOptionList: state.isExtraOption ? state.defaultOptionList : filterDefaultOption(state.input),
        input: '',
      };
    default:
      throw new Error('옵션 선택 action error');
  }
}

function useFilter() {
  const [state, dispatch] = useReducer(reducer, initState);

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
    handleClickExtraOption,
    handleClickDefaultOption,
    handleClickExtraCategory,
    handleClickDefaultCategory,
    handleChangeInput,
    handleClickSearchButton,
  } as const;
}

export default useFilter;
