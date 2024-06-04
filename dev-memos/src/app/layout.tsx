// src/app/layout.tsx
import './globals.css';
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'My Keep App',
  description: 'A simple note-taking application',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ja">
      <body className={`${inter.className} flex min-h-screen bg-gray-100`}>
        {/* サイドバー（後でコンポーネント化） */}
        <aside className="w-64 bg-white p-4 shadow-md">
          <h2 className="text-xl font-bold mb-4">My Keep</h2>
          <nav>
            <ul>
              <li className="mb-2">
                <a href="#" className="block p-2 rounded hover:bg-gray-200">
                  メモ
                </a>
              </li>
              <li className="mb-2">
                <a href="#" className="block p-2 rounded hover:bg-gray-200">
                  アーカイブ
                </a>
              </li>
            </ul>
          </nav>
        </aside>

        {/* メインコンテンツ */}
        <main className="flex-1 p-8">{children}</main>
      </body>
    </html>
  );
}