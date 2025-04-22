import * as React from 'react';
import Backdrop from '@mui/material/Backdrop';
import { TextField } from '@mui/material';
import AddIcon from '@mui/icons-material/Add';
import Fab from '@mui/material/Fab';
import { Button } from '@mui/material';
import Box from '@mui/material/Box';

export default function SimpleBackdrop(height, width, name) {
  const [open, setOpen] = React.useState(false);
  const [playlistname, setPlaylistName] = React.useState('');

  const handleClose = () => {
    setOpen(false);
  };
  const handleOpen = () => {
    setOpen(true);
  };

  const handleChange = (event) => {
    setPlaylistName(event.target.value);
  };

  const handleSubmit = () => {
    name(playlistname);
    setOpen(false);
  };

  return (
    <div>
        <Box height={height} width={width} sx={{ border: '2px solid grey' }}>
        <Fab color="primary" aria-label="add" size='small' sx={{top: '1.9vh'}}>
            <AddIcon onClick={handleOpen}/>
        </Fab>
        </Box>
        <Backdrop
            sx={{ color: 'black', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={open}
            onClick={handleClose}
        >
            <Box color={'white'}>
            <TextField
            type="text"
            placeholder="Playlist Name"
            value={playlistname}
            style={{width: '30vw', marginTop: '0vh'}}
            onChange={handleChange}
            variant='standard'
            />
            <Button onClick={handleSubmit} >Submit</Button>
            </Box>
        </Backdrop>
    </div>
  );
}