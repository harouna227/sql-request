import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'
import {createBrowserRouter, RouterProvider, Link} from 'react-router-dom'
import Article from './Article.jsx';

// Creation des routes
const router = createBrowserRouter([
  {path: "/", element: <App />},
  {path: "apropos", element: (
        <>
          <h1>A propos</h1>
          <p>Je suis un paragraphe</p>
          <Link to="/">About</Link>
        </>
  )},
  {path: "blog", element: (
    <>
      <h2>Liste des Articles</h2>
      <Link to="/blog/14">Article 14</Link>
    </>
  )},
  {path: "blog/:id", element: 
    (<>
      <Article />
    </>)
   }
]);

createRoot(document.getElementById('root')).render(
  <RouterProvider router={router} />
)

