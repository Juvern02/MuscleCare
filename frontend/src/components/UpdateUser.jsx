import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import Button from '@mui/material/Button';
import Checkboxes from './CheckBoxes.jsx';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import axios from 'axios';
import VIDEO from './Videos/index.js';
import FormDialog from './Dialog.jsx';

const UpdateUser = () => {
    const [userData, setUserData] = useState();
    const [UpdateInjuries, setUpdateInjuries] = useState('');
    const [UpdateUsername, setUpdateUsername] = useState('');
    const [UpdatePassword, setUpdatePassword] = useState('');
    const [error, setError] = useState('');
    const [Playlists, setPlaylists] = useState([]);
    const [newPlaylistName, setNewPlaylistName] = useState('');
    const [ShowPlaylists, setShowPlaylists] = useState(false);

    useEffect(() => {
        const data = window.localStorage.getItem('LOGINDATA')
        if (data && data !== "undefined"){
          setUserData(JSON.parse(data));
          if(userData){
            getPlaylist(userData.username);
          }
        }
      },[])
    
      useEffect(() => {
        window.localStorage.setItem('LOGINDATA', JSON.stringify(userData))
    }, [userData])

    const UpdateUser = async (e) => {
        e.preventDefault();
        try {
        const response = await axios.post('http://127.0.0.1:8000/update_user/', { 
            username: userData.username,
            newUsername: UpdateUsername, 
            password: UpdatePassword, 
            injuries: UpdateInjuries 
        });
        setUserData(response.data.user)
        console.log(response)
        } catch (error) {
        setError('Invalid username or password');
        }
    };
    
    const getPlaylist = async (username) => {
        try {
        const response = await axios.post(`http://127.0.0.1:8000/getPlaylist/${username}`);
        setPlaylists(response.data.videos)
        console.log(response)
        } catch (error) {
            setError(error);
        }
    };

    const handleShowPlaylists = () =>{
        if(userData){
            getPlaylist(userData?.username)
        }
        setShowPlaylists(true)
    }

    const handleHidePlaylists = () => {
        setShowPlaylists(false)
    }

    return(
        <div style={{textAlign: 'center'}}>
        <Typography variant="h5" component="div" sx={{width: '100%' , marginTop:'2vh', marginBottom:'2vh'}}>Welcome {userData?.username}</Typography>
            {ShowPlaylists && Playlists ? (
                <div>
                    <Typography variant="h6" component="div" sx={{width: '100%' , marginTop:'2vh', marginBottom:'2vh'}}>Your Playlists</Typography>
                    <div style={{display: 'flex', flexWrap: 'wrap', maxWidth:'40vw', justifyContent: 'center'}}> 
                        {Playlists.map((playlist, index) => (   
                        <Link to={`/userplaylist/${userData?.username}/${playlist.name}` } style={{ textDecoration: 'none' }}>
                            <Typography variant="h6" component="div" style={{color:'#00a791', marginBottom: '1vh'}}>{playlist.name}</Typography>
                            <video autoPlay loop src={VIDEO[playlist.url]} style={{height: '11vw', width: '19.36vw', border: '2px solid grey'}}></video>
                        </Link>
                ))}
                <div>
                <Typography variant="h6" component="div" style={{color:'#00a791',  marginBottom: '1vh'}}>Add New</Typography>
                <FormDialog 
                height= {'11vw'}
                width={"19.36vw"} 
                username={userData?.username}
                onSubmit={getPlaylist}/>
                </div>
                </div>
                <Button onClick={handleHidePlaylists}>Hide Playlists</Button>
                </div>
            ) : (
                <Button onClick={handleShowPlaylists}>Show Playlists</Button>
            )}
        <Divider style={{marginTop: '1.5vh'}}/>
        <Box style={{display:'block',textAlign: 'center'}}>
            <Typography variant="h6" component="div" sx={{width: '100%' , marginTop:'1vh'}}>Edit User Details</Typography>
            <p>Username: {userData?.username}</p>
            <TextField
            type="text"
            placeholder="Edit Username"
            value={UpdateUsername}
            style={{width: '30vw', marginTop: '0vh'}}
            onChange={(e) => setUpdateUsername(e.target.value)}
            />
            <TextField
            type="password"
            placeholder="Change Password"
            value={UpdatePassword}
            style={{width: '30vw', marginTop: '1.5vh'}}
            onChange={(e) => setUpdatePassword(e.target.value)}
            />
            <p>
            Injuries: {userData && userData.injuries && userData.injuries.map((injury, index) => (
                <React.Fragment key={index}>
                  {injury}
                  {index !== userData.injuries.length - 1 && ', '}
                </React.Fragment>))}
            </p>
            <Checkboxes value = {UpdateInjuries} onChange={setUpdateInjuries} placeholder={userData?.injuries}/>
            <Button onClick={UpdateUser} style={{marginTop: '1.5vh'}}>Apply Changes</Button>
        </Box>
        </div>
    )
}

export default UpdateUser;