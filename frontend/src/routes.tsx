import { Routes as RouterRoutes, Route, Navigate } from 'react-router-dom';
import { LoginPage } from './pages/auth/LoginPage';
import { SignupPage } from './pages/auth/SignupPage';
import ProtectedRoute from './components/auth/ProtectedRoute';

const Routes = () => {
  return (
    <RouterRoutes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/signup" element={<SignupPage />} />
      <Route path="/dashboard" element={
        <ProtectedRoute>
          <div>Dashboard</div>
        </ProtectedRoute>
      } />
      <Route path="/" element={<Navigate to="/dashboard" replace />} />
    </RouterRoutes>
  );
};

export default Routes;