import React, { useEffect, useState } from 'react';
import { styled, useTheme } from '@mui/material/styles';
import { useParams, Link, useNavigate } from 'react-router-dom';
import axios from 'axios';
import ReactPlayer from 'react-player';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import MuiAppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import CssBaseline from '@mui/material/CssBaseline';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import profile from './Images/Profile.png';
import IMAGES from './Images/index.js';
import VIDEO from './Videos/index.js';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import LoginForm from './Login.jsx';
import { List } from '@mui/material';
import PlaylistDialog from './Dialog3.jsx';

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
    position: 'relative',
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

export default function PersistentDrawerRight() {
  const theme = useTheme();
  const [open, setOpen] = React.useState(false);
  const [secondaryDrawerOpen, setSecondaryDrawerOpen] = React.useState(false);
  const [drawerWidth, setDrawerWidth] = useState(window.innerWidth * 0.4);
  const [activeImage, setActiveImage] = useState([]);
  const [videos, setVideos] = useState([]);
  const [userData, setUserData] = useState();
  const navigate = useNavigate();

  useEffect(() => {
    const data = window.localStorage.getItem('LOGINDATA')
    if (data && data !== "undefined"){
      setUserData(JSON.parse(data));
    }
  },[])

  useEffect(() => {
    const fetchData = async () => {
      console.log(activeImage);
      try {
        const response = await axios.post(`http://127.0.0.1:8000/get_videos_for_muscles/${activeImage}`);
        setVideos(response.data.videos);
      } catch (error) {
        console.error('Error fetching videos:', error);
      }
    };

    if (activeImage.length > 0) {
      fetchData();
    }
  ;

    const handleResize = () => {
      setDrawerWidth(window.innerWidth * 0.4);
    };

    window.addEventListener('resize', handleResize);
    
    const data = window.localStorage.getItem('LOGINDATA')
    if (data && data !== "undefined"){
      setUserData(JSON.parse(data));
    }
    
    console.log(userData)

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
      <Main open={open || secondaryDrawerOpen} drawerWidth={drawerWidth} className='MainPage'>
        <DrawerHeader>
        <div className='MaleModel'>
        <img
          src={activeImage.includes('Abdominals') ? IMAGES.redRightAbs : IMAGES.rightAbs}
          className="rightAbs"
          onClick={() => handleImageClick('Abdominals')}
        />
        <img
          src={activeImage.includes('Bicep') ? IMAGES.redRightBicep : IMAGES.rightBicep}
          className="rightBicep"
          onClick={() => handleImageClick('Bicep')}
        />
        <img
          src={activeImage.includes('Chest') ? IMAGES.redRightChest : IMAGES.rightChest}
          className="rightChest"
          onClick={() => handleImageClick('Chest')}
        />
        <img
          src={activeImage.includes('Forearm') ? IMAGES.redRightForearm : IMAGES.rightForearm}
          className="rightForearm"
          onClick={() => handleImageClick('Forearm')}
        />
        <img src={IMAGES.rightLowerLeg} className="rightLowerLeg"/>
        <img
          src={activeImage.includes('Outer Abdominals') ? IMAGES.redRightOuterAbs : IMAGES.rightOuterAbs}
          className="rightOuterAbs"
          onClick={() => handleImageClick('Outer Abdominals')}
        />
        <img
          src={activeImage.includes('Quads') ? IMAGES.redRightQuads : IMAGES.rightQuads}
          className="rightQuads"
          onClick={() => handleImageClick('Quads')}
        />
        <img
          src={activeImage.includes('Shoulder') ? IMAGES.redRightShoulder : IMAGES.rightShoulder}
          className="rightShoulder"
          onClick={() => handleImageClick('Shoulder')}
        />
        <img
          src={activeImage.includes('Abdominals') ? IMAGES.redLeftAbs : IMAGES.leftAbs}
          className="leftAbs"
          onClick={() => handleImageClick('Abdominals')}
        />
        <img
          src={activeImage.includes('Bicep') ? IMAGES.redLeftBicep : IMAGES.leftBicep}
          className="leftBicep"
          onClick={() => handleImageClick('Bicep')}
        />
        <img
          src={activeImage.includes('Chest') ? IMAGES.redLeftChest : IMAGES.leftChest}
          className="leftChest"
          onClick={() => handleImageClick('Chest')}
        />
        <img
          src={activeImage.includes('Forearm') ? IMAGES.redLeftForearm : IMAGES.leftForearm}
          className="leftForearm"
          onClick={() => handleImageClick('Forearm')}
        />
        <img src={IMAGES.leftLowerLeg} className="leftLowerLeg"/>
        <img
          src={activeImage.includes('Outer Abdominals') ? IMAGES.redLeftOuterAbs : IMAGES.leftOuterAbs}
          className="leftOuterAbs"
          onClick={() => handleImageClick('Outer Abdominals')}
        />
        <img
          src={activeImage.includes('Quads') ? IMAGES.redLeftQuads : IMAGES.leftQuads}
          className="leftQuads"
          onClick={() => handleImageClick('Quads')}
        />
        <img
          src={activeImage.includes('Shoulder') ? IMAGES.redLeftShoulder : IMAGES.leftShoulder}
          className="leftShoulder"
          onClick={() => handleImageClick('Shoulder')}
        />
        <img src={IMAGES.rightOutline} className="rightOutline" />
        <img src={IMAGES.leftOutline} className="leftOutline" />
        </div>
        </DrawerHeader>
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
        open={open}
      >
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
        <DrawerHeader justifyContent="center" >
        <Typography variant="h5" component="div" sx={{ textAlign: 'center', width: '100%', color: '#00a791' }}>
          {activeImage.join(' + ')}
        </Typography>
        </DrawerHeader>
        <Divider />
        <List>
          {videos.map(videos => (
            <div id='DrawerListBox' key = {videos.url}>
              <h3 id='DrawerListHeader'>{videos.title}</h3>
              <div style={{ position: 'relative' }}>
                <Link to={`/exercise/${videos.id}`}>
                  <video autoPlay loop style={{ width: '100%', height: 'auto' }}>
                    <source src={VIDEO[videos.url]} type="video/mp4" />
                  </video>
                </Link>
                {userData && (
                  <div style={{ position: 'absolute', bottom: 8, right: 0, marginRight: '0' }}>
                    <PlaylistDialog username={userData.username} videoID={videos.id} />
                  </div>
                )}
              </div>
              {videos.danger && (
                <div>
                  <p style={{ display: 'inline', color: 'red', fontWeight: 'bold'}}>Dangerous for: </p>
                  <p style={{ display: 'inline', color: 'orange', fontWeight: 'bold' }}>{videos.danger}</p>
                </div>
              )}
            </div>
          ))}
        </List>
      </Drawer>
    </Box>
  );
}
