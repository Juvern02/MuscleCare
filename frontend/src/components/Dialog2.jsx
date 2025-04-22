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
import VIDEO from './Videos';
import ImageList from '@mui/material/ImageList';
import ImageListItem from '@mui/material/ImageListItem';
import ImageListItemBar from '@mui/material/ImageListItemBar';
import axios from 'axios';

export default function VideoDialog({ height, width, playlistname, username}) {
  const [open, setOpen] = React.useState(false);
  const [name, setName] = React.useState('');
  const [videolist, setVideoList] = React.useState([]);

  React.useEffect(()=> {
    const getVideos = async () => {
      try{
        const response = await axios.post(`http://127.0.0.1:8000/get_all_videos`);
        setVideoList(response.data.videos);
        console.log(response.data.videos)
      } catch(error) {
        console.log(error)
      }
    }
    if(username && playlistname){
      getVideos();
    }
  },[]);

  const handleOpen = () => {
    setOpen(true);
  };

  const handleClose = async (videoID) => {
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
      <div style={{justifyContent:'center', display:'flex', alignItems:'center', height:'20vw', width: '50vw', backgroundColor:'#efefef', borderRadius:'8px'}}>
          <Box height={height} width={width} justifyContent={'center'} display={'flex'} alignItems={'center'} sx={{ border: '2px solid grey'}}>
            <Fab color="primary" aria-label="add" size='medium'>
              <AddIcon onClick={handleOpen} />
            </Fab>
          </Box>
          <p style={{textAlign:'center', color:'black', marginLeft:'1.5vw'}}>Add Video</p>
          </div>
      
      <Dialog open={open}>
        <DialogTitle>Create Playlist</DialogTitle>
        <DialogContent>
          <DialogContentText>
            Which Video do you want to add
          </DialogContentText>
          <ImageList sx={{ width: 500, height: 450 }} cols={3} rowHeight={164}>
            {videolist.map((video) => (
              <ImageListItem key={videolist.id} onClick={() => handleClose(video.id)}>
                <video autoPlay loop style={{ width: '70%', height: 'auto'}}>
                  <source src={VIDEO[video.url]} type="video/mp4" />
                </video>
                <ImageListItemBar position="below" title={video.title} />
              </ImageListItem>
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