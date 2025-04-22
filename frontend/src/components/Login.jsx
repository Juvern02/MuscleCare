import React, { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import axios from 'axios';
import Button from '@mui/material/Button';
import Signup from './Signup.jsx'
import Checkboxes from './CheckBoxes.jsx';
import Typography from '@mui/material/Typography';
import TextField from '@mui/material/TextField';
import Box from '@mui/material/Box';
import Divider from '@mui/material/Divider';
import UpdateUser from './UpdateUser.jsx';

const LoginForm = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [userData, setUserData] = useState();
  const [showSignup, setShowSignup] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const data = window.localStorage.getItem('LOGINDATA')
    if (data && data !== "undefined"){
      setUserData(JSON.parse(data));
    }
  },[])

  useEffect(() => {
    window.localStorage.setItem('LOGINDATA', JSON.stringify(userData))
  }, [userData])

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post(`http://127.0.0.1:8000/signin/`, { username, password });
      if(response.data.success == 'True'){
        setUserData(response.data.user)
      } else {
        setError(response.data.error)
      }
    } catch (error) {
      setError('Server Error');
    }
  };
  
  const handleSignupButtonClick = () => {
    setShowSignup(true);
  };

  const handleLogout = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://127.0.0.1:8000/logout/', { 
        username: userData?.username });
        if (response.data.success == 'True'){
          setUserData(null);
          setTimeout(() => {
            navigate('/');  
          }, 1000);
        }
    } catch (error) {
      setError('Invalid username or password');
    }
  };

  return (
    <div>
      {!userData && (
        <div style={{ display:'block', textAlign: 'center'}}>
          <Typography 
          variant="h6" 
          noWrap sx={{ flexGrow: 1 }} 
          style={{marginTop: '1vh', color: 'rgb(0, 167, 145)'}}
          component="div">
              Sign in
          </Typography>
      <form onSubmit={handleLogin}>
        <TextField
          type="text"
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          style={{marginTop: '1vh'}}
        />
        <TextField
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          style={{marginTop: '1vh'}}
        />
        <div>
        <Button type="submit" variant="contained" style={{marginTop: '1vh'}}>Login</Button>
        </div>
        {error && <p style={{color: 'red'}}>{error}</p>}
      </form>
      <h3>Or</h3>
      {!showSignup && (
      <div style={{ textAlign: 'center' }}>
        <Button variant="contained" onClick={handleSignupButtonClick}>Sign Up</Button>
      </div>
    )}
    {showSignup && <Signup />}
    </div>
    )}
    {userData && (
      <div style={{textAlign: 'center'}}>
      <UpdateUser/>
      <Divider/>
      <Button onClick={handleLogout} color="error" style={{marginTop: '1.5vh'}}>Logout</Button>
      </div>
    )}    
    </div>
  );
};

export default LoginForm;