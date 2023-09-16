"use client";
import React, { useState } from 'react';

export default function Home() {
  const [input, setInput] = useState("");
  const [imgsrc, setImgsrc] = useState("");
  function handleInputChange(event) {
    const inputValue = event.target.value;
    setInput(inputValue);
  }

  async function GenerateQR() {
    let data = input;
    if (data.length > 0) {
      let img = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=" + data;
      setImgsrc(img);
    }
  }

  return (
    <main className="flex min-h-screen flex-col items-center p-24">
      <h1 className="text-5xl text-pink-600">Home</h1>
      <div className='flex flex-col mt-4'>
        <input
          type="text"
          name="name"
          placeholder='Enter data'
          className='text-black'
          value={input}
          onChange={handleInputChange}
        />
        <button type="submit" onClick={GenerateQR} className='my-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full transition duration-300 ease-in-out'>Generate QR</button>
        {imgsrc ? (
          <div>
            <img src={imgsrc} />
          </div>
        ) : (
          <h1>hello</h1>
        )}
      </div>

    </main>
  );
}
