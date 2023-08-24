import { useRef } from 'react';
import styled from '@emotion/styled';
import { MainSelector } from '../common/MainSelector';
import TrimCard from './TrimCard';
import { TrimResponse } from '@/types/response';
import { getImagePreloader } from '@/utils/image';

interface Props {
  trimList: TrimResponse[];
  selectedTrimId: number;
  onSelectTrim: (trim: TrimResponse) => void;
}

function TrimSelector({ trimList, selectedTrimId, onSelectTrim }: Props) {
  const imageLoaderRef = useRef(getImagePreloader());

  const handleMouseOver = (images: string[]) => {
    imageLoaderRef.current(images);
  };

  return (
    <MainSelector title='트림을 선택해주세요'>
      <TrimList>
        {trimList.map((trim) => {
          const { id, name, images, ...rest } = trim;
          return (
            <TrimCard
              key={id}
              id={id}
              title={name}
              isSelected={id === selectedTrimId}
              onClick={() => onSelectTrim(trim)}
              onMouseOver={() => handleMouseOver(images)}
              {...rest}
            />
          );
        })}
      </TrimList>
    </MainSelector>
  );
}

export default TrimSelector;

const TrimList = styled.ul`
  display: flex;
  gap: 16px;
  width: 100%;
`;
