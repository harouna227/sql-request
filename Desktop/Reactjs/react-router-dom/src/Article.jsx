import React from 'react'
import { useParams } from 'react-router-dom'

export default function Article() {
    const { id } = useParams();
  return (
    <div>
        <h2>Voici un article avec id :{ id }</h2>
    </div>
  )
}
