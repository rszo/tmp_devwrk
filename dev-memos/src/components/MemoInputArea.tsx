// src/components/MemoInputArea.tsx
import React, { useState } from 'react';
import { Memo } from '../types/memo';
import { Transition } from '@headlessui/react';

interface MemoInputAreaProps {
  onSave: (memo: Memo) => void;
}

const MemoInputArea: React.FC<MemoInputAreaProps> = ({ onSave }) => {
  const [isExpanded, setIsExpanded] = useState(false);
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');

  const handleSave = () => {
    if (!title && !content) {
      setIsExpanded(false);
      return;
    }

    const newMemo: Memo = {
      id: Date.now().toString(),
      title,
      content,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      isArchived: false,
      tags: [],
    };
    onSave(newMemo);
    setTitle('');
    setContent('');
    setIsExpanded(false);
  };

  const handleFocus = () => {
    setIsExpanded(true);
  };

  const handleBlur = (e: React.FocusEvent) => {
    // フォームの外をクリックしたら保存する
    if (!e.currentTarget.contains(e.relatedTarget as Node)) {
      handleSave();
    }
  };

  return (
    <div
      className={`bg-white rounded-lg shadow-md p-4 mb-8 mx-auto max-w-xl transition-all duration-300 ${isExpanded ? 'ring-2 ring-blue-500' : ''}`}
      onBlur={handleBlur}
      tabIndex={0} // for onBlur to work correctly
    >
      <Transition
        show={isExpanded}
        enter="transition-opacity duration-200"
        enterFrom="opacity-0"
        enterTo="opacity-100"
        leave="transition-opacity duration-200"
        leaveFrom="opacity-100"
        leaveTo="opacity-0"
      >
        <input
          type="text"
          placeholder="タイトル"
          className="w-full p-2 mb-2 text-lg font-semibold border-b border-gray-300 focus:outline-none"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          onFocus={handleFocus}
        />
      </Transition>

      <textarea
        placeholder="メモを作成..."
        className="w-full p-2 resize-none focus:outline-none"
        rows={isExpanded ? 5 : 1}
        value={content}
        onChange={(e) => setContent(e.target.value)}
        onFocus={handleFocus}
      ></textarea>

      <Transition
        show={isExpanded}
        enter="transition-opacity duration-200"
        enterFrom="opacity-0"
        enterTo="opacity-100"
        leave="transition-opacity duration-200"
        leaveFrom="opacity-100"
        leaveTo="opacity-0"
      >
        <div className="flex justify-end mt-2">
          <button
            onClick={handleSave}
            className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition-colors"
          >
            保存
          </button>
        </div>
      </Transition>
    </div>
  );
};

export default MemoInputArea;