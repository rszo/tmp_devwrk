// pages/index.tsx
import { useState } from 'react';
import { Bookmark } from '../types';
import BookmarkList from '../components/BookmarkList';
import BookmarkForm from '../components/BookmarkForm';
import { PlusIcon } from '@heroicons/react/24/outline';
import { v4 as uuidv4 } from 'uuid'; // npm install uuid @types/uuid

export default function Home() {
  const [bookmarks, setBookmarks] = useState<Bookmark[]>([]);
  const [isFormOpen, setIsFormOpen] = useState(false);

  const handleAddBookmark = (newBookmark: Omit<Bookmark, 'id'>) => {
    const bookmarkWithId: Bookmark = { ...newBookmark, id: uuidv4() };
    setBookmarks((prevBookmarks) => [...prevBookmarks, bookmarkWithId]);
  };

  const handleDeleteBookmark = (id: string) => {
    setBookmarks((prevBookmarks) => prevBookmarks.filter((bookmark) => bookmark.id !== id));
  };

  return (
    <div className="min-h-screen bg-gray-100 py-10">
      <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 className="text-3xl font-extrabold text-gray-900 text-center mb-8">
          ブックマークマネージャー
        </h1>

        <div className="flex justify-end mb-6">
          <button
            onClick={() => setIsFormOpen(true)}
            className="inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
          >
            <PlusIcon className="-ml-1 mr-2 h-5 w-5" aria-hidden="true" />
            新しいブックマーク
          </button>
        </div>

        <BookmarkList bookmarks={bookmarks} onDeleteBookmark={handleDeleteBookmark} />

        <BookmarkForm
          isOpen={isFormOpen}
          onClose={() => setIsFormOpen(false)}
          onAddBookmark={handleAddBookmark}
        />
      </div>
    </div>
  );
}