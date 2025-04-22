import './App.css';
import ExercisePage from './components/ExercisePage.jsx';
import UserPlaylists from './components/UserPlaylists.jsx'
import { Home } from './components/home.js';
import { Routes, Route } from 'react-router-dom';

function App() {
  return (
    <div>
      <Routes>
        <Route path="/" element={< Home />}/>
        <Route path="/exercise/:id" element={<ExercisePage/>}/>
        <Route path="/userplaylist/:username/:playlistname" element={<UserPlaylists/>}/>
      </Routes>
    </div>
  );
}

export default App;
