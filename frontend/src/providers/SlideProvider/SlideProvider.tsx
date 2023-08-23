import type { Dispatch, PropsWithChildren, SetStateAction } from 'react';
import { createContext, useState } from 'react';

export interface SlideContextType {
  currentSlide: number;
  setCurrentSlide: Dispatch<SetStateAction<number>>;
}

export const SlideContext = createContext<SlideContextType | null>(null);

function SlideProvider({ children }: PropsWithChildren) {
  const [currentSlide, setCurrentSlide] = useState(0);

  return <SlideContext.Provider value={{ currentSlide, setCurrentSlide }}>{children}</SlideContext.Provider>;
}

export default SlideProvider;
