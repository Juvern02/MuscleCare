import React, { useState, useEffect, useRef} from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { styled, useTheme } from '@mui/material/styles';
import axios from 'axios';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import CssBaseline from '@mui/material/CssBaseline';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import VIDEO from './Videos/index.js';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import LoginForm from './Login.jsx';
import Button from '@mui/material/Button';
import RemoveCircleOutlineIcon from '@mui/icons-material/RemoveCircleOutline';
import FormDialog from './Dialog.jsx';
import VideoDialog from './Dialog2.jsx';

const Main = styled('main', { shouldForwardProp: (prop) => prop !== 'open' })(
    ({ theme, open, secondaryDrawerOpen, drawerWidth }) => ({
      flexGrow: 1,
      padding: theme.spacing(0),
      transition: theme.transitions.create('margin', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
      }),
      marginRight: -drawerWidth,
      ...(open && { 
        transition: theme.transitions.create('margin', {
          easing: theme.transitions.easing.easeOut,
          duration: theme.transitions.duration.enteringScreen,
        }),
        marginRight: 0,
      }),
    }),
  );
  
  const AppBar = styled(MuiAppBar, {
    shouldForwardProp: (prop) => prop !== 'open',
  })(({ theme, open, secondaryDrawerOpen, drawerWidth }) => ({
    transition: theme.transitions.create(['margin', 'width'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    ...(open || secondaryDrawerOpen && { 
      width: `calc(100% - ${drawerWidth}px)`,
      transition: theme.transitions.create(['margin', 'width'], {
        easing: theme.transitions.easing.easeOut,
        duration: theme.transitions.duration.enteringScreen,
      }),
      marginRight: drawerWidth,
    }),
    boxShadow: 'none',
  }));
  
  const DrawerHeader = styled('div')(({ theme }) => ({
    display: 'flex',
    alignItems: 'center',
    padding: theme.spacing(0, 1),
    ...theme.mixins.toolbar,
    justifyContent: 'flex-start',
  }));

  const Datalist = ({ username, playlistname }) => {
    const draggingPos = useRef(null);
    const dragOverPos = useRef(null);
    const [items, setItems] = useState([]);
  
    useEffect(() => {
      const selectPlaylists = async () => {
        try {
          const response = await axios.post(`http://127.0.0.1:8000/selectPlaylist/${playlistname}/${username}`);
          if (response.data.success === "True") {
            const sortedItems = response.data.videos.sort((a, b) => a.order - b.order);
            setItems(sortedItems);
          } else {
            console.log(response.data.error);
          }
        } catch (error) {
          console.log(error);
        }
      };
      if (username && playlistname) {
        selectPlaylists();
      }
    }, [username, playlistname]);

    useEffect(() =>{
    },[items])

    const updatePlaylistOrder = async () => {
      try {
        const response = await axios.post(`http://127.0.0.1:8000/update_playlist_order/${playlistname}/${username}`, {
          orders: items
        });
        if (response.data.success === "True") {
          console.log(items)
            window.location.reload();

        } else {
          console.log(response.data.error);
        }
      } catch (error) {
        console.log(error);
      }
    };

    const selectPlaylists = async () => {
      try {
        const response = await axios.post(`http://127.0.0.1:8000/selectPlaylist/${playlistname}/${username}`);
        console.log(response.data.videos)
        if (response.data.success === "True") {
          const sortedItems = response.data.videos.sort((a, b) => a.order - b.order);
          setItems(sortedItems);
        } else {
          console.log(response.data.error);
        }
      } catch (error) {
        console.log(error);
      }
    };

    const deleteVideo = async (ordernumber) => {
      try {
          const response = await axios.post(`http://127.0.0.1:8000/remove_from_playlist/${playlistname}/${username}/${ordernumber}`);
          console.log(response.data.videos)
          if (response.data.success === 'True') {
            selectPlaylists();
          } else {
            console.log(response.data.error);
          }
        } catch (error) {
          console.log(error);
        }
    }

    const handleDragStart = (position) => {
      draggingPos.current = position;
    };
  
    const handleDragEnter = (position) => {
      dragOverPos.current = position;
      const newItems = [...items];
      const draggingItem = newItems[draggingPos.current];
      if (!draggingItem) return
  
      newItems.splice(draggingPos.current, 1);
      newItems.splice(dragOverPos.current, 0, draggingItem);
  
      const reorderedItems = newItems.map((item, index) => ({
        ...item,
        order: index
      }));
  
      draggingPos.current = position;
      dragOverPos.current = null;
  
      setItems(reorderedItems);
    };

    const handleDragEnd = () => {
      updatePlaylistOrder();
    };
  
    return (
      <div>
        {items.map((item, index) => (
          <div
            key={item.order}
            className='item'
            draggable
            onDragStart={() => handleDragStart(index)}
            onDragEnter={() => handleDragEnter(index)}
            onDragEnd={handleDragEnd}
            onDragOver={(e) => e.preventDefault()}
          >
            <div style={{display:'flex', height:'20vw', width: '50vw', backgroundColor:'#efefef', borderRadius:'8px', alignItems:'center'}}>
            <RemoveCircleOutlineIcon style={{marginLeft: '1.5vw'}} onClick={() => deleteVideo(item.order)}/>
            <div style={{justifyContent:'center', display:'flex', alignItems:'center', width:'auto'}}>
            <video autoPlay loop style={{ width: 'auto', height: '12vw', maxWidth: '500px',  marginLeft:'1.5vw'}}>
              <source src={VIDEO[item.url]} type="video/mp4" />
            </video>
            <p style={{textAlign:'center', color:'black', marginLeft:'1.5vw', maxWidth:'13vw'}}>{item.name}</p>
            <p style={{textAlign:'center', color:'#00a791', font:'Rowdies', marginLeft:'1.5vw'}}> {index}</p>
            </div>
            </div>
          </div>
        ))}
        <VideoDialog width={ '23vw' } height={ '13vw'} username={username} playlistname={playlistname}/>
      </div>
    );
  };

export default function UserPlaylists(){
    const params = useParams()
    const theme = useTheme();
    const [open, setOpen] = React.useState(false);
    const [secondaryDrawerOpen, setSecondaryDrawerOpen] = React.useState(false);
    const [drawerWidth, setDrawerWidth] = useState(window.innerWidth * 0.3);
    const [activeImage, setActiveImage] = useState([]);
    const [exercise, setExercise] = useState([]);
    const [showSignup, setShowSignup] = useState(false);
    const navigate = useNavigate();
  
    const handleSignupButtonClick = () => {
      setShowSignup(true);
    };
  
    useEffect(() => {
      const fetchData = async () => {
        console.log(activeImage);
        try {
          const response = await axios.post(`http://127.0.0.1:8000/get_video/${params.id}`);
          console.log(response)
          setExercise(response.data);
        } catch (error) {
          console.error('Error fetching videos:', error);
        }
      };
  
      if (activeImage.length > 0) {
        fetchData();
      }
    ;
  
      const handleResize = () => {
        setDrawerWidth(window.innerWidth* 0.3);
      };
  
      window.addEventListener('resize', handleResize);
  
      return () => {
        window.removeEventListener('resize', handleResize);
      };
    }, [activeImage]);
  
    const handleSecondaryDrawerOpen = () => {
      handleImageClick("")
      setOpen(true);
      setSecondaryDrawerOpen(true);
    };
  
    const handleSecondaryDrawerClose = () => {
      handleImageClick("");
      setSecondaryDrawerOpen(false);
    };
  
    const RouteHome = () => {
        navigate('/');
    }
  
    const handleImageClick = (image) => {
      setActiveImage(prevActiveImage => {
        if (prevActiveImage.includes(image)) {
          const updatedActiveImage = prevActiveImage.filter(item => item !== image);
          if (updatedActiveImage.length === 0) {
            setOpen(false);
          }
          return updatedActiveImage;
        } else {
          setOpen(true);
          return [...prevActiveImage, image];
        }
      });
    };

    const DeletePlaylist = async () => {
      try {
        const response = await axios.post(`http://127.0.0.1:8000/remove_playlist/${params.username}/${params.playlistname}`);
        if (response.data.success == 'True'){
          RouteHome();
        }
      } catch (error) {
        console.error('Error fetching videos:', error);
      }
    }
  
    return (
      <Box sx={{ display: 'flex' }}>
        <CssBaseline />
        <AppBar position="fixed" secondaryDrawerOpen={open || secondaryDrawerOpen} drawerWidth={drawerWidth}>
          <Toolbar className='MainPage-Header'>
            <Typography 
            variant="h5" 
            noWrap sx={{ flexGrow: 1 }} 
            component="div"
            onClick={RouteHome}>
                MuscleCare
            </Typography>
            <IconButton
              edge="start"
              color="inherit"
              aria-label="menu"
              onClick={handleSecondaryDrawerOpen}
            >
              <MenuIcon/>
            </IconButton>
          </Toolbar>
        </AppBar>
        <Main open={open || secondaryDrawerOpen} drawerWidth={drawerWidth} className='ExercisePage'>
          <div style={{marginTop: '2.6vh'}}>
            <div className='exerciseInfo'>
              <div style={{display:'flex' }}>
              {params && <Datalist username={params.username} playlistname={params.playlistname} />}
              <div style={{textAlign: 'center', position:'relative', width:'45vw', left:'2vw', marginRight:'2vw'}}>
                <Typography
                variant="h5" 
                noWrap sx={{ flexGrow: 1 }} 
                component="div"
                color= '#efefef'
                >
                  {params.playlistname}
                </Typography>
                <Button color="error" onClick={DeletePlaylist} style={{marginTop: '1vw'}}>
                  Delete Playlist
                </Button>
                </div>
              </div>
            </div>
            </div>
        </Main>
        <Drawer
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          '& .MuiDrawer-paper': {
            width: (drawerWidth+18),
            backgroundColor: '#ebf2eb'
          },
        }}
        variant="persistent"
        anchor="right"
          open={secondaryDrawerOpen}
        >
          <DrawerHeader>
            <IconButton onClick={handleSecondaryDrawerClose}>
              <ChevronLeftIcon/>
            </IconButton>
            <Typography variant="h5" component="div" sx={{ textAlign: 'center', width: '100%', color: '#00a791' }}>
              Account Settings
            </Typography>
          </DrawerHeader>
          <Divider/>
          <LoginForm/>
        </Drawer>
      </Box>
    );
}
