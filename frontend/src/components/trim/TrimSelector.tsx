import { useRef } from 'react';
import { TrimResponse } from '@/types/response';
import { Flex, MainSelector } from '@/components/common';
import { TrimCard } from '@/components/trim';
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
      <Flex gap={16} width='100%'>
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
      </Flex>
    </MainSelector>
  );
}

export default TrimSelector;
