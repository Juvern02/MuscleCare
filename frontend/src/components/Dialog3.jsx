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
import ImageList from '@mui/material/ImageList';
import { List } from '@mui/material';
import axios from 'axios';

export default function PlaylistDialog({username, videoID}) {
  const [open, setOpen] = React.useState(false);
  const [name, setName] = React.useState('');
  const [Playlist, setPlaylist] = React.useState([]);

  React.useEffect(()=>{
    console.log('hello')
  },[])

  React.useEffect(()=> {
    const getVideos = async () => {
      try{
        const response = await axios.post(`http://127.0.0.1:8000/getPlaylist/${username}`);
        setPlaylist(response.data.videos);
        console.log('me')
      } catch(error) {
        console.log(error)
      }
    }
    if(open){
      getVideos();
    }
  },[open]);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = async (playlistname) => {
    try{
      const response = await axios.post(`http://127.0.0.1:8000/add_to_playlist/${playlistname}/${username}/${videoID}`);
    } catch (error) {
      console.log(error)
    }
    setOpen(false);
    window.location.reload();
  };

  const Cancel = () => {
    setOpen(false);
  } 

  return (
    <React.Fragment>
      <Fab color="primary" aria-label="add" size='small'>
        <AddIcon onClick={handleOpen} />
      </Fab>
      <Dialog open={open}>
        <DialogTitle>Create Playlist</DialogTitle>
        <DialogContent>
          <DialogContentText>
            What Playlist do you want to add this video to?
          </DialogContentText>
          <ImageList sx={{ width: 500, height: 'auto' }} cols={3} rowHeight={164}>
            {Playlist.map((playlist) => (
              <List key={playlist.name}>
                <Button onClick={() => handleClose(playlist.name)}>{playlist.name}</Button>
              </List>
            ))}
          </ImageList>
        </DialogContent>
        <DialogActions>
          <Button type="error" onClick={Cancel}>Cancel</Button>
        </DialogActions>
      </Dialog>
    </React.Fragment>
  );
}