import React, { useState, useEffect } from 'react';
import Login from './components/Login';
import Register from './components/Register';
import CandidateDashboard from './components/CandidateDashboard';
import HRDashboard from './components/HRDashboard';
import './App.css';

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [userRole, setUserRole] = useState(null);
  const [showLogin, setShowLogin] = useState(true);

  useEffect(() => {
    // Check if user is already logged in
    const token = localStorage.getItem('token');
    const role = localStorage.getItem('role');

    if (token && role) {
      setIsAuthenticated(true);
      setUserRole(role);
    }
  }, []);

  const handleLogin = (role) => {
    setIsAuthenticated(true);
    setUserRole(role);
  };

  const handleRegister = (role) => {
    setIsAuthenticated(true);
    setUserRole(role);
  };

  const handleLogout = () => {
    setIsAuthenticated(false);
    setUserRole(null);
  };

  const switchToRegister = () => {
    setShowLogin(false);
  };

  const switchToLogin = () => {
    setShowLogin(true);
  };

  if (!isAuthenticated) {
    return (
      <div className="App">
        {showLogin ? (
          <Login onLogin={handleLogin} onSwitchToRegister={switchToRegister} />
        ) : (
          <Register onRegister={handleRegister} onSwitchToLogin={switchToLogin} />
        )}
      </div>
    );
  }

  return (
    <div className="App">
      {userRole === 'candidate' ? (
        <CandidateDashboard onLogout={handleLogout} />
      ) : (
        <HRDashboard onLogout={handleLogout} />
      )}
    </div>
  );
}

export default App;
