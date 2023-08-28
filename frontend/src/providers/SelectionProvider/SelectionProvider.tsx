import { Dispatch, PropsWithChildren, createContext, useMemo } from 'react';
import useSelectionReducer, { type Action, type State } from './hooks/useSelectionReducer';

interface SelectionContextType {
  selectionInfo: State;
  totalPrice: number;
  dispatch: Dispatch<Action>;
}

export const SelectionContext = createContext<SelectionContextType | null>(null);

function SelectionProvider({ children }: PropsWithChildren) {
  const [state, dispatch] = useSelectionReducer();

  const totalPrice = useMemo(() => {
    const { trim, powerTrain, bodyType, driveTrain, exteriorColor, interiorColor, extraOptions } = state;
    const options = [trim, powerTrain, bodyType, driveTrain, exteriorColor, interiorColor, extraOptions];

    return options.reduce((acc, curr) => acc + (curr?.price || 0), 0);
  }, [state]);

  const contextValue = useMemo(
    () => ({
      selectionInfo: state,
      totalPrice,
      dispatch,
    }),
    [state, totalPrice],
  );

  return <SelectionContext.Provider value={contextValue}>{children}</SelectionContext.Provider>;
}

export default SelectionProvider;
