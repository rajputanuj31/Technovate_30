import Link from "next/link"
import { ConnectButton } from '@rainbow-me/rainbowkit';

export default function Navbar() {
    return (
        <div className="flex items-center justify-between m-2">
            <div>
                <Link href="/" className="mx-8 text-xl font-bold">Home</Link>
                <Link href="/about" className="mx-8 text-xl font-bold">About</Link>
                <Link href="/contact" className="mx-8 text-xl font-bold">Contact</Link>
            </div>
            <ConnectButton className="mx-8" />
        </div>
    )
}
