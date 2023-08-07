import { useState } from 'react';
import styled from '@emotion/styled';
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
    <TrimSelectorContainer>
      <div>
        <h2>트림을 선택해주세요</h2>
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
      </div>
    </TrimSelectorContainer>
  );
}

export default TrimSelector;

const TrimSelectorContainer = styled.div`
  width: 100%;
  min-height: calc(100vh - 420px);
  padding-top: 16px;
  background-color: white;

  & > div {
    max-width: 1024px;
    width: 100%;
    margin: 0 auto;
  }

  h2 {
    ${({ theme }) => theme.typography.HeadKRMedium16}
    margin-bottom: 12px;
  }
`;

const TrimList = styled.ul`
  display: flex;
  gap: 16px;
  width: 100%;
`;
