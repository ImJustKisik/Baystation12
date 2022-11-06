import { Fragment } from 'inferno';
import { useBackend } from 'tgui/backend';
import { AnimatedNumber, Button, Flex, LabeledControls, ProgressBar, Section } from 'tgui/components';
import { Window } from 'tgui/layouts';
import { logger } from '../logging';
import { LabeledList } from '../components';
import { round } from 'common/math';

const getBrainActivityColor = (activity) => {
  if (activity > 90) return 'good';
  if (activity > 50) return 'orange';
  return 'bad';
};

const getBrainActivityStatus = (activity) => {
  if (activity === -1) return 'HARDWARE ERROR';
  if (activity >= 70 && activity < 90) return 'Minor';
  if (activity >= 40 && activity < 70) return 'Weak';
  if (activity >= 10 && activity < 40) return 'Extremely Weak';
  if (activity > 0 && activity < 10) return 'Fading';
  if (activity === 0) return 'Brain dead';
  return 'Normal';
};

export const CryoCell = () => {
  return (
    <Window width={400} height={550} resizable>
      <Window.Content scrollable>
        <CryoContent />
      </Window.Content>
    </Window>
  );
};

const CryoContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { occupant = null, cellTemperature, cellTemperatureStatus, beakerLabel, beakerVolume, beakerCapacity } = data;
  logger.log(occupant);
  const isBeakerLoaded = !!beakerLabel;
  return (
    <Fragment>
      <Section>
        <LabeledControls>
          <LabeledControls.Item label="Temperature">
            <ProgressBar value={cellTemperature} minValue={0} maxValue={294} width={20} color={cellTemperatureStatus}>
              <AnimatedNumber value={cellTemperature} /> &deg;K
            </ProgressBar>
          </LabeledControls.Item>
          <LabeledControls.Item label="Power">
            <Button
              icon={data.isOperating ? 'power-off' : 'times'}
              disabled={data.isOpen}
              onClick={() => act('power')}
              color={data.isOperating && 'green'}>
              {data.isOperating ? 'On' : 'Off'}
            </Button>
          </LabeledControls.Item>
        </LabeledControls>
      </Section>
      <Section
        title="Occupant"
        buttons={
          <Button icon="eject" disabled={!data.hasOccupant} onClick={() => act('ejectOccupant')} content="Eject" />
        }>
        <LabeledList>
          <LabeledList.Item label="Occupant">{(data.occupant && data.occupant.name) || 'No Occupant'}</LabeledList.Item>
          {!!data.hasOccupant && (
            <>
              <LabeledList.Item label="State" color={data.occupant.statState}>
                {data.occupant.stat}
              </LabeledList.Item>
              <LabeledList.Item label="Temperature" color={data.occupant.temperaturestatus}>
                <AnimatedNumber value={round(data.occupant.temperature, 1)} />
                {' K ('}
                <AnimatedNumber value={round(data.occupant.temperature - 273, 1)} />
                {'°C)'}
              </LabeledList.Item>
              <LabeledList.Item label="Brain activity" color={getBrainActivityColor(data.occupant.brain_activity)}>
                {getBrainActivityStatus(data.occupant.brain_activity)}
              </LabeledList.Item>
              <LabeledList.Item
                label="Pulse rate"
                color={
                  data.occupant.pulse <= 0
                    ? 'bad'
                    : data.occupant.pulse > 90 || data.occupant.pulse < 60
                    ? 'orange'
                    : 'good'
                }>
                {data.occupant.pulse === -1 ? 'ERROR' : `${data.occupant.pulse} bpm`}
              </LabeledList.Item>
            </>
          )}
        </LabeledList>
      </Section>
      <Section
        title="Beaker"
        buttons={<Button icon="eject" disabled={!isBeakerLoaded} onClick={() => act('ejectBeaker')} content="Eject" />}>
        <ProgressBar value={beakerVolume} minValue={0} maxValue={beakerCapacity || Infinity}>
          <Flex justify="space-between">
            <Flex.Item>{(isBeakerLoaded && beakerLabel) || 'None loaded'}</Flex.Item>
            <Flex.Item>
              {beakerVolume} / {beakerCapacity}u
            </Flex.Item>
          </Flex>
        </ProgressBar>
      </Section>
    </Fragment>
  );
};
