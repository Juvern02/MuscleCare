import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { styled, useTheme } from '@mui/material/styles';
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
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import CardMedia from '@mui/material/CardMedia';
import CardContent from '@mui/material/CardContent';
import CardActions from '@mui/material/CardActions';
import profile from './Images/Profile.png';
import IMAGES from './Images/index.js';
import VIDEO from './Videos/index.js';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import LoginForm from './Login.jsx';
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

  const ExerciseDetails = ({ exerciseId }) => {
    const [exercise, setExercise] = useState(null);
    const [userData, setUserData] = useState();
    const [commonDanger, setCommonDanger] = useState(false);

    useEffect(() => {
      const data = window.localStorage.getItem('LOGINDATA')
      if (data && data !== "undefined") {
          setUserData(JSON.parse(data));
      }
      console.log(userData)
    },[])

    useEffect(() => {
      const fetchData = async () => {
        if(userData){
          try {
            const response = await axios.post(`http://127.0.0.1:8000/select_user_video/${exerciseId}/${userData?.username}`);
            console.log(response.data);
            if (response.data.success === 'True') {
              const fetchedExercise = response.data.video;
              setExercise(fetchedExercise);
              const isCommonDanger = userData.injuries && fetchedExercise.danger && userData.injuries.some(injury => fetchedExercise.danger.includes(injury));
              setCommonDanger(isCommonDanger);
              console.log(isCommonDanger)
            }
          } catch (error) {
            console.error(error);
            console.log(error);
            }
        }else{
          try {
          const response = await axios.post(`http://127.0.0.1:8000/get_video/${exerciseId}`);
          console.log(response.data);
          if (response.data.success === 'True') {
            const fetchedExercise = response.data.video;
            setExercise(fetchedExercise);
            const isCommonDanger = userData?.injuries && fetchedExercise.danger && userData.injuries.some(injury => fetchedExercise.danger.includes(injury));
            console.log(isCommonDanger)
            setCommonDanger(isCommonDanger);
          }
        } catch (error) {
          console.error(error);
          }
        }
      };

      fetchData();
  
      return () => {
        setExercise(null);
      };
    }, [exerciseId]);
  
    if (!exercise) {
      return <div>
      <h1 style={{color: '#efefef'}}>Loading...</h1>
      </div>;
    }
  
    return (
      <div>
        <div style={{ display: 'flex', marginTop: '1vh', position: 'relative' }}>
          <video autoPlay loop style={{ width: '50%', height: 'auto', maxWidth: '500px', marginTop: '3vh' }}>
            <source src={VIDEO[exercise.url]} type="video/mp4" />
          </video>
          {userData && (
            <div style={{ position: 'absolute', bottom: 0, left: 0, marginRight: '0' }}>
              <PlaylistDialog username={userData.username} videoID={exercise.id} />
            </div>
          )}
          <div style={{ marginRight: '2.8vw', marginLeft: '2vw' }}>
            <h2 style={{ textAlign: 'center' }}>{exercise.title}</h2>
            <p>{exercise.desc}</p>
          </div>
        </div>
        {commonDanger && (
        <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'right' }}>
          <Card style={{ display: 'block', marginLeft: '8vw', maxWidth: '700px', marginRight: '10vw', marginTop: '2vh', justifyContent: 'center' }}>
            <div style={{ display: 'flex', justifyContent: 'center', marginBottom: '-4vh' }}>
              <h3 style={{ color: '#ff586d' }}>
                Injuries: {userData.injuries.map((injury, index) => (
                  <React.Fragment key={index}>
                    {injury}
                    {index !== userData.injuries.length - 1 && ', '}
                  </React.Fragment>
                ))}
              </h3>
            </div>
            <CardContent style={{ display: 'flex', alignItems: 'center' }}>
              <p style={{ color: '#00a791', marginRight: '1vh' }}>{exercise.AIText}</p>
              <div style={{ position: 'relative' }}>
                <Link to={`/exercise/${exercise.recID}`}>
                  <video autoPlay loop style={{ width: '100%', height: 'auto', maxWidth: '100%' }}>
                    <source src={VIDEO[exercise.recExercise]} type="video/mp4" />
                  </video>
                </Link>
                {userData && (
                  <div style={{ position: 'absolute', bottom: 8, right: 1 }}>
                    <PlaylistDialog username={userData.username} videoID={exercise.recID} />
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </div>
      )}
      </div>
    );
  };

export default function ExercisePage(){
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
            <div className='exerciseInfo'>
                {params.id && <ExerciseDetails exerciseId={params.id} />}
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
