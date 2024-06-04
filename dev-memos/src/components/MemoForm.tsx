// src/components/MemoForm.tsx
import React, { useState, useEffect } from 'react';
import { Dialog, Transition } from '@headlessui/react';
import { Fragment } from 'react';
import { Memo } from '../types/memo';

interface MemoFormProps {
  isOpen: boolean;
  onClose: () => void;
  onSave: (memo: Memo) => void;
  initialMemo?: Memo | null;
}

const MemoForm: React.FC<MemoFormProps> = ({ isOpen, onClose, onSave, initialMemo }) => {
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [color, setColor] = useState('');

  useEffect(() => {
    if (initialMemo) {
      setTitle(initialMemo.title);
      setContent(initialMemo.content);
      setColor(initialMemo.color || '');
    } else {
      setTitle('');
      setContent('');
      setColor('');
    }
  }, [initialMemo, isOpen]); // isOpenも依存に含めることで、フォーム開閉時にリセットされる

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!title && !content) return;

    const newMemo: Memo = {
      id: initialMemo?.id || Date.now().toString(), // 新規の場合はIDを生成
      title,
      content,
      createdAt: initialMemo?.createdAt || Date.now(),
      updatedAt: Date.now(),
      isArchived: initialMemo?.isArchived || false,
      tags: initialMemo?.tags || [],
      color: color || undefined,
    };
    onSave(newMemo);
    onClose();
  };

  const colors = ['#ffffff', '#fbbc04', '#fff475', '#ccff90', '#a7ffeb', '#cbf0f8', '#aecbfa', '#d7aefb', '#fdcfe8', '#e6c9a8', '#e8eaed'];

  return (
    <Transition appear show={isOpen} as={Fragment}>
      <Dialog as="div" className="relative z-10" onClose={onClose}>
        <Transition.Child
          as={Fragment}
          enter="ease-out duration-300"
          enterFrom="opacity-0"
          enterTo="opacity-100"
          leave="ease-in duration-200"
          leaveFrom="opacity-100"
          leaveTo="opacity-0"
        >
          <div className="fixed inset-0 bg-black bg-opacity-25" />
        </Transition.Child>

        <div className="fixed inset-0 overflow-y-auto">
          <div className="flex min-h-full items-center justify-center p-4 text-center">
            <Transition.Child
              as={Fragment}
              enter="ease-out duration-300"
              enterFrom="opacity-0 scale-95"
              enterTo="opacity-100 scale-100"
              leave="ease-in duration-200"
              leaveFrom="opacity-100 scale-100"
              leaveTo="opacity-0 scale-95"
            >
              <Dialog.Panel className="w-full max-w-md transform overflow-hidden rounded-2xl bg-white p-6 text-left align-middle shadow-xl transition-all">
                <Dialog.Title as="h3" className="text-lg font-medium leading-6 text-gray-900 mb-4">
                  {initialMemo ? 'メモを編集' : 'メモを作成'}
                </Dialog.Title>
                <form onSubmit={handleSubmit}>
                  <div className="mb-4">
                    <input
                      type="text"
                      placeholder="タイトル"
                      className="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                      value={title}
                      onChange={(e) => setTitle(e.target.value)}
                    />
                  </div>
                  <div className="mb-4">
                    <textarea
                      placeholder="メモを入力..."
                      className="w-full p-2 border border-gray-300 rounded-md h-32 resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
                      value={content}
                      onChange={(e) => setContent(e.target.value)}
                    ></textarea>
                  </div>
                  <div className="mb-4 flex space-x-2">
                    {colors.map((c) => (
                      <button
                        key={c}
                        type="button"
                        className="w-8 h-8 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        style={{ backgroundColor: c }}
                        onClick={() => setColor(c)}
                        title={c === '#ffffff' ? 'デフォルト' : c}
                      >
                        {color === c && (
                          <svg className="w-full h-full text-gray-800" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                            <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"></path>
                          </svg>
                        )}
                      </button>
                    ))}
                  </div>
                  <div className="mt-4 flex justify-end space-x-2">
                    <button
                      type="button"
                      className="inline-flex justify-center rounded-md border border-transparent bg-gray-100 px-4 py-2 text-sm font-medium text-gray-900 hover:bg-gray-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-gray-500 focus-visible:ring-offset-2"
                      onClick={onClose}
                    >
                      キャンセル
                    </button>
                    <button
                      type="submit"
                      className="inline-flex justify-center rounded-md border border-transparent bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2"
                    >
                      保存
                    </button>
                  </div>
                </form>
              </Dialog.Panel>
            </Transition.Child>
          </div>
        </div>
      </Dialog>
    </Transition>
  );
};

export default MemoForm;