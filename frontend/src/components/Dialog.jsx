import * as React from 'react';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';
import Box from '@mui/material/Box';
import Fab from '@mui/material/Fab';
import AddIcon from '@mui/icons-material/Add';
import axios from 'axios';

export default function FormDialog({ height, width, username, onSubmit}) {
    const [open, setOpen] = React.useState(false);
    const [name, setName] = React.useState('');
  
    const handleOpen = () => {
      setOpen(true);
    };
  
    const handleClose = () => {
      setOpen(false);
    };

    const handleSubmit = async (event) => {
      event.preventDefault();
      try {
          const response = await axios.post(`http://127.0.0.1:8000/add_playlist/${username}/${name}`);
          if (response.data.success === 'True'){
            onSubmit(username);
            handleClose();
          }
          console.log(response)} 
          catch (error) {
          
          }
    };
  
    return (
      <React.Fragment>
        <Box height={height} width={width} justifyContent={'center'} display={'flex'} alignItems={'center'} sx={{ border: '2px solid grey'}}>
          <Fab color="primary" aria-label="add" size='medium'>
            <AddIcon onClick={handleOpen} />
          </Fab>
        </Box>
        <Dialog
          open={open}
          onClose={handleClose}
          PaperProps={{
            component: 'form',
            onSubmit: handleSubmit,
          }}
        >
          <DialogTitle>Create Playlist</DialogTitle>
          <DialogContent>
            <DialogContentText>
              Enter the name of the playlist:
            </DialogContentText>
            <TextField
              autoFocus
              required
              margin="dense"
              id="name"
              label="Playlist Name"
              type="text"
              fullWidth
              value={name}
              onChange={(e) => setName(e.target.value)}
            />
          </DialogContent>
          <DialogActions>
            <Button type="error" onClick={handleClose}>Cancel</Button>
            <Button type="submit">Create</Button>
          </DialogActions>
        </Dialog>
      </React.Fragment>
    );
  }