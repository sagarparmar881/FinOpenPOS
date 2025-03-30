import { createClient } from '@/lib/supabase/server'
import { NextResponse } from 'next/server'
import { use } from 'react';

export async function PUT(
  request: Request,
  { params }: { params: { productId?: string, orderId?: string } }
) {
  const supabase = createClient();

  const { data: { user } } = await supabase.auth.getUser();
  
  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const updatedData = await request.json();
  const { productId, orderId } = params;

  if (!productId && !orderId) {
    return NextResponse.json({ error: 'No valid ID provided' }, { status: 400 });
  }

  let response;

  if (productId) {
    const { data, error } = await supabase
      .from('products')
      .update({ ...updatedData, user_uid: user.id })
      .eq('id', productId)
      .eq('user_uid', user.id)
      .select();

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    if (!data.length) {
      return NextResponse.json({ error: 'Product not found or not authorized' }, { status: 404 });
    }

    response = data[0];
  }

  if (orderId) {
    const { data, error } = await supabase
      .from('orders')
      .update({ ...updatedData, user_uid: user.id })
      .eq('id', orderId)
      .eq('user_uid', user.id)
      .select();

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    if (!data.length) {
      return NextResponse.json({ error: 'Order not found or not authorized' }, { status: 404 });
    }

    response = data[0];
  }

  return NextResponse.json(response);
}

export async function DELETE(
  request: Request,
  { params }: { params: { productId?: string, orderId?: string } }
) {
  const supabase = createClient();

  const { data: { user } } = await supabase.auth.getUser();

  console.log(user);
  
  if (!user) {
    return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
  }

  const productId = params.productId;
  const orderId = params.orderId;

  if (!productId && !orderId) {
    return NextResponse.json({ error: 'Missing productId or orderId' }, { status: 400 });
  }

  if (productId) {
    const { error } = await supabase
      .from('products')
      .delete()
      .eq('id', productId)
      .eq('user_uid', user.id);

    if (error) {
      console.log("Error deleting product:", error.message);
      return NextResponse.json({ error: error.message }, { status: 500 });
    }
  }

  if (orderId) {
    const orderDelete = await supabase
      .from('orders')
      .delete()
      .eq('id', orderId)
      .eq('user_uid', user.id);

    if (orderDelete.error) {
      return NextResponse.json({ error: orderDelete.error.message }, { status: 500 });
    }
  }

  return NextResponse.json({ message: 'Deletion successful' });
}
