import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';

const Signup = () => {
  const [username, setUsername] = useState('');
  const [password1, setPassword1] = useState('');
  const [password2, setPassword2] = useState('');
  const [email, setEmail] = useState('');
  const [error, setError] = useState(''); 
  const [userData, setData] = useState();

  useEffect(() => {
    window.localStorage.setItem('LOGINDATA', userData)
  }, [userData])

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await axios.post('http://127.0.0.1:8000/signup/', { 
        username: username, 
        email: email, 
        password1: password1, 
        password2: password2 });
        console.log(response.data)

        if(response.data.success === 'False' && response.data.error){
            let errorMessage = '';
          if (response.data.error.email) {
            errorMessage += response.data.error.email.join(' ');
          }
          if (response.data.error.password2) {
            errorMessage += ' ' + response.data.error.password2.join(' ');
          }
          if (response.data.error.username) {
            errorMessage += ' ' + response.data.error.username.join(' ');
          }
          console.log(errorMessage)
          setError(errorMessage);
        }else{
          setData('Account Created')
        }
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <form onSubmit={handleLogin}>
      <TextField
        type="text"
        placeholder="Username"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        style={{marginTop: '1vh'}}
      />
      <TextField
        type="text"
        placeholder="Email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        style={{marginTop: '1vh'}}
      />
      <TextField
        type="password"
        placeholder="Password1"
        value={password1}
        onChange={(e) => setPassword1(e.target.value)}
        style={{marginTop: '1vh'}}
      />
      <TextField
        type="password"
        placeholder="Password2"
        value={password2}
        onChange={(e) => setPassword2(e.target.value)}
        style={{marginTop: '1vh'}}
      />
      <div>
      <Button type="submit" variant="contained" style={{marginTop: '1vh'}} >Sign Up</Button>
      </div>
      {error && <p style={{color: "red"}}>{error}</p>}
    </form>
  );
};

export default Signup;