import { createTheme } from '@mui/material/styles';

const theme = createTheme({
    palette: {
        primary: {
          main: '#2192f3', // Your custom primary color
        },
        secondary: {
          main: '#ff4081', // Your custom secondary color
        },
      },

    typography: {
        fontFamily: 'Roboto, sans-serif', // Your custom font family
        h6: {
        color: '#efefef', // Your custom color for h6 variant
        },
    },
});

export default theme;