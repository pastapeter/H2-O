import styled from '@emotion/styled';
import ModelTypeCard from './ModelTypeCard';
import type { BodyType, DriveTrain, PowerTrain } from '@/types/response';
import { Flex, Typography } from '@/components/common';

type ModelType = PowerTrain | BodyType | DriveTrain;
interface Props<T extends ModelType> {
  name: string;
  selectedId: number;
  options?: T[];
  onSelect: (data: T) => void;
}

function ModelTypeOptionList<T extends ModelType>({ name, selectedId, options = [], onSelect }: Props<T>) {
  return (
    <Flex flexDirection='column'>
      <Typography font='HeadKRMedium14' color='gray600' marginBottom={4}>
        {name}
      </Typography>
      <OptionContainer as='ul' gap={5}>
        {options.map((option) => {
          const { id, name, ...props } = option;

          return (
            <ModelTypeCard
              as='li'
              key={name}
              isSelected={selectedId === id}
              name={name}
              onClick={() => onSelect(option)}
              {...props}
            />
          );
        })}
      </OptionContainer>
    </Flex>
  );
}

export default ModelTypeOptionList;

const OptionContainer = styled(Flex)`
  background-color: ${({ theme }) => theme.colors.gray50};
  border-radius: 8px;
  padding: 4px;
`;
