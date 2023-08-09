import { useState } from 'react';
import styled from '@emotion/styled';
import { MainSelector } from '../common/MainSelector';
import TrimCard from './TrimCard';

type Trim = {
  id: number;
  title: string;
  description: string;
  price: number;
};

interface Props {
  trimList: Trim[];
}

function TrimSelector({ trimList }: Props) {
  const [selectedTrim, setSelectedTrim] = useState('Le Blanc');

  const handleClickCard = (title: string) => {
    setSelectedTrim(title);
  };

  return (

    <MainSelector title='트림을 선택해주세요'>
      <TrimList>
        {trimList.map(({ id, title, ...rest }) => (
          <TrimCard
            key={id}
            title={title}
            isSelected={title === selectedTrim}
            onClick={() => handleClickCard(title)}
            {...rest}
          />
        ))}
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
