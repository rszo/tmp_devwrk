// components/BookmarkList.tsx
import React from 'react';
import { Bookmark } from '../types'; // 後で定義します
import { TrashIcon } from '@heroicons/react/24/outline';

interface BookmarkListProps {
  bookmarks: Bookmark[];
  onDeleteBookmark: (id: string) => void;
}

const BookmarkList: React.FC<BookmarkListProps> = ({ bookmarks, onDeleteBookmark }) => {
  return (
    <div className="mt-8">
      {bookmarks.length === 0 ? (
        <p className="text-center text-gray-500">まだブックマークはありません。</p>
      ) : (
        <ul className="space-y-4">
          {bookmarks.map((bookmark) => (
            <li key={bookmark.id} className="bg-white shadow overflow-hidden rounded-md px-4 py-4 sm:px-6 flex items-center justify-between">
              <div>
                <a href={bookmark.url} target="_blank" rel="noopener noreferrer" className="text-lg font-medium text-indigo-600 hover:text-indigo-500">
                  {bookmark.title}
                </a>
                <p className="mt-1 text-sm text-gray-500">{bookmark.url}</p>
              </div>
              <button
                onClick={() => onDeleteBookmark(bookmark.id)}
                className="ml-4 p-2 rounded-full text-red-400 hover:text-red-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
              >
                <TrashIcon className="h-5 w-5" aria-hidden="true" />
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default BookmarkList;