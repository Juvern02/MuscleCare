import React, { useEffect } from 'react';
import Checkbox from '@mui/material/Checkbox';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import CheckBoxOutlineBlankIcon from '@mui/icons-material/CheckBoxOutlineBlank';
import CheckBoxIcon from '@mui/icons-material/CheckBox';

const icon = <CheckBoxOutlineBlankIcon fontSize="small" />;
const checkedIcon = <CheckBoxIcon fontSize="small" />;

export default function Checkboxes({ value, onChange, placeholder }) {
  const [selectedValues, setSelectedValues] = React.useState(value || []);

  useEffect(() => {
    setSelectedValues(value || []);
  }, [value]);

  return (
    <Autocomplete
      multiple
      id="checkboxes-tags-demo"
      options={Muscles}
      disableCloseOnSelect
      getOptionLabel={(option) => option.title}
      value={selectedValues}
      onChange={(event, newValue) => {
        setSelectedValues(newValue);
        if (onChange) {
          onChange(newValue);
        }
      }}
      renderOption={(props, option, { selected }) => (
        <li {...props}>
          <Checkbox
            icon={icon}
            checkedIcon={checkedIcon}
            style={{ marginRight: 8 }}
            checked={selected}
          />
          {option.title}
        </li>
      )}
      style={{ width: '30vw', marginLeft: 'auto', marginRight: 'auto', marginTop: '1.5vh' }}
      renderInput={(params) => (
        <TextField {...params} label="Set Injuries" />
      )}
    />
  );
}

const Muscles = [
  { title: 'Quads' },
  { title: 'Abdominals' },
  { title: 'Foream' },
  { title: 'UpperBack' },
  { title: 'Elbow' },
  { title: 'Outer Abdominals' },
  { title: 'Bicep' },
  { title: 'Tricep' },
  { title: 'LowerBack' },
  { title: 'Shoulder' },
  { title: 'Chest' },
];
