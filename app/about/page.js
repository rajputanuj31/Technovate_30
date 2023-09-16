"use client";

import axios from 'axios';
import { useEffect, useState } from 'react';

export default function About() {

  const [jsonIPFS, setJSONipfs] = useState('');
  const [patient, setPatient] = useState('');
  const [price, setPrice] = useState('');
  const [tokenID, setTokenID] = useState('');
  const [medicine, setMedicine] = useState('');

  useEffect(async () => {

    if (jsonIPFS != '') {
      console.log(jsonIPFS);
    }

  }, [jsonIPFS])


  async function JSONtoIPFS() {

    var data = JSON.stringify({
      "pinataOptions": {
        "cidVersion": 1
      },
      "pinataMetadata": {
        "name": "testing",
        "keyvalues": {
          "customKey": "customValue",
          "customKey2": "customValue2"
        }
      },
      "pinataContent": {
        "name": `SARIDON`,
        "tokenID": `2`,
        "price": `Hello`,
        "to": `${patient}`
      }
    });

    var config = {
      method: 'post',
      url: 'https://api.pinata.cloud/pinning/pinJSONToIPFS',
      headers: {
        'Content-Type': 'application/json',
        pinata_api_key: `973d88cee1e9f726c4d0`,
        pinata_secret_api_key: `dd9c271562331a79ba1a19d4f3212ef2f3f117c9c30b42c5020c70a8f0990428`,
      },
      data: data
    };

    const res = await axios(config);
    setJSONipfs(res.data.IpfsHash);

  }

  async function getMedicineDetails (){

  }

  return (
    <div>
      <button onClick={JSONtoIPFS}>Check</button>

      <input
        type="text"
        placeholder="Patient Address"
        onChange={(
          (e) => {
            setPatient(e.target.value)
          }
        )}
      />

      <input
        type="text"
        className=''
        placeholder="Medicine to Prescribe"
        onChange={(
          (e) => {
            setMedicine(e.target.value)
          }
        )}
      />

    </div>
  )
}
